
cp -n $BOARTESTHOME/test_tree.tar.gz . || exit 1
cp -n $BOARTESTHOME/test_tree.md5 . || exit 1
cp -n $BOARTESTHOME/test_tree_addition.tar.gz . || exit 1
cp -n $BOARTESTHOME/test_tree_addition.md5 . || exit 1

export REPO="`pwd`/TESTREPO"
export CLONE="${REPO}_CLONE"

echo --- Test mkrepo, mksession and import
tar -xvzf test_tree.tar.gz || { echo "Couldn't create test tree"; exit 1; }
md5sum -c test_tree.md5 || { echo "Test tree failed md5 before check-in"; exit 1; }
$BOAR mkrepo $REPO || { echo "Couldn't create repo"; exit 1; }
REPO_PATH=$REPO $BOAR mksession MyTestSession || { echo "Couldn't create session"; exit 1; }
REPO_PATH=$REPO $BOAR import -nv test_tree MyTestSession || { echo "Couldn't dry-run import tree"; exit 1; }
test -e test_tree/.boar && { echo "Dry-run import should not create a workdir"; exit 1; }
REPO_PATH=$REPO $BOAR list MyTestSession 2 && { echo "Dry-run import actually performed an import"; exit 1; }
REPO_PATH=$REPO $BOAR import -W -m"import åäö" -v test_tree MyTestSession || { echo "Couldn't import tree"; exit 1; }
(REPO_PATH=$REPO $BOAR list MyTestSession | grep "import åäö") || { echo "List command for session did not contain expected log message"; exit 1; }

echo --- Test co
rm -r test_tree || { echo "Couldn't remove test tree after import"; exit 1; }
REPO_PATH=$REPO $BOAR co MyTestSession test_tree || { echo "Couldn't check out tree"; exit 1; }
md5sum -c test_tree.md5 || { echo "Test tree failed md5 after check-out"; exit 1; }

echo --- Test that status command gives no notice or warning msg
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
REPO_PATH=$REPO $BOAR co MyTestSession test_tree || { echo "Couldn't check out tree"; exit 1; }
(cd test_tree && REPO_PATH=$REPO $BOAR status 2>../errors.txt)
grep . errors.txt && { cat errors.txt; echo "Status command caused an error message"; exit 1; }
rm -r errors.txt || exit 1

echo --- Test --repo flag
$BOAR list && { echo "Did not get expected error when listing undefined repo --repo option"; exit 1; }
$BOAR --repo $REPO list || { echo "Couldn't access repo by pre-cmd --repo option"; exit 1; }
$BOAR list --repo $REPO || { echo "Couldn't access repo by post-cmd --repo option"; exit 1; }
$BOAR --repo=$REPO list || { echo "Couldn't access repo by pre-cmd --repo= option"; exit 1; }
$BOAR list --repo=$REPO || { echo "Couldn't access repo by post-cmd --repo= option"; exit 1; }

echo --- Test unchanged check-in
(cd test_tree && $BOAR ci --allow-empty ) || { echo "Couldn't check in tree"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree after check-in"; exit 1; }
REPO_PATH=$REPO $BOAR co MyTestSession test_tree || { echo "Couldn't check out tree"; exit 1; }
md5sum -c test_tree.md5 || { echo "Test tree failed md5 after unmodified check-in"; exit 1; }

echo --- Test status command
( cd test_tree && $BOAR status -v ) || { echo "Couldn't execute status command"; exit 1; }
# By redirecting, we are forcing the output stream to ascii, which will blow up on unicode.
( cd test_tree && $BOAR status -v >/dev/null ) || { echo "Couldn't execute redirected status command"; exit 1; }

echo --- Test info command
( cd test_tree && $BOAR info ) || { echo "Couldn't execute info command"; exit 1; }
( cd test_tree && $BOAR info | grep "Workdir root" >/dev/null ) || { echo "Info command didn't return expected data"; exit 1; }

echo --- Test list command
REPO_PATH=$REPO $BOAR list || { echo "Couldn't execute list command"; exit 1; }
REPO_PATH=$REPO $BOAR list MyTestSession || { echo "Couldn't execute list command for session "; exit 1; }
REPO_PATH=$REPO $BOAR list MyTestSession 3 || { echo "Couldn't execute list command for snapshot "; exit 1; }

echo --- Test exportmd5 command
( cd test_tree && $BOAR exportmd5 ) || { echo "Couldn't export md5sum"; exit 1; }
( cd test_tree && md5sum -c md5sum.txt ) || { echo "Couldn't verify exported md5sum"; exit 1; }
( cd test_tree && rm md5sum.txt ) || { echo "Couldn't remove exported md5sum"; exit 1; }

echo --- Test detection of non-repo
rm -rf NOTAREPO
mkdir NOTAREPO || exit 1
$BOAR verify --repo=NOTAREPO && { echo "Non-repo was not detected"; exit 1; }
mkdir NOTAREPO/tmp || exit 1
$BOAR verify --repo=NOTAREPO && { echo "Non-repo was not detected"; exit 1; }
mkdir NOTAREPO/blobs || exit 1
$BOAR verify --repo=NOTAREPO && { echo "Non-repo was not detected"; exit 1; }
mkdir NOTAREPO/sessions || exit 1
$BOAR verify --repo=NOTAREPO && { echo "Non-repo was not detected"; exit 1; }
$BOAR verify --repo=NOTAREPO 2>&1 | grep "does not contain a valid repository" || \
    { echo "Non-repo gave unexpected error message"; exit 1; }
rm -r NOTAREPO

echo --- Test adding files to a base session
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
tar -xvzf test_tree_addition.tar.gz || { echo "Couldn't create test tree for addition"; exit 1; }
REPO_PATH=$REPO $BOAR import -W -v test_tree MyTestSession || { echo "Couldn't import added files"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
REPO_PATH=$REPO $BOAR co MyTestSession test_tree || { echo "Couldn't check out tree"; exit 1; }
md5sum -c test_tree.md5 || { echo "Test tree failed md5 after addition"; exit 1; }
md5sum -c test_tree_addition.md5 || { echo "Test tree addition failed md5 after addition"; exit 1; }

echo --- Test adding the same file again
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
tar -xvzf test_tree_addition.tar.gz || { echo "Couldn't create test tree for addition"; exit 1; }
REPO_PATH=$REPO $BOAR import -W -v test_tree MyTestSession || { echo "Couldn't import added files"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
REPO_PATH=$REPO $BOAR co MyTestSession test_tree || { echo "Couldn't check out tree"; exit 1; }
md5sum -c test_tree.md5 || { echo "Test tree failed md5 after addition"; exit 1; }
md5sum -c test_tree_addition.md5 || { echo "Test tree addition failed md5 after addition"; exit 1; }

echo --- Test offset checkout
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
REPO_PATH=$REPO $BOAR co MyTestSession/subdir test_tree || { echo "Couldn't check out tree"; exit 1; }
md5sum -c <<EOF || { echo "Offset checkout failed"; exit 1; }
2490f86515a5a58067c2a1ca3e239299  test_tree/fil1.txt
EOF
test `find test_tree -type f -a ! -ipath *.boar*` == "test_tree/fil1.txt" || { echo "More files than expected in checkout"; exit 1; }

echo --- Test offset checkin
echo "Some content" >test_tree/nysubfil.txt
(cd test_tree && $BOAR ci -m "ci åäö") || { echo "Couldn't check in tree"; exit 1; }
(REPO_PATH=$REPO $BOAR list MyTestSession | grep "ci åäö") || { echo "List command for session did not contain expected log message"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
REPO_PATH=$REPO $BOAR co MyTestSession/subdir test_tree || { echo "Couldn't check out tree"; exit 1; }
md5sum -c <<EOF || { echo "Offset checkout failed"; exit 1; }
2490f86515a5a58067c2a1ca3e239299  test_tree/fil1.txt
581ab2d89f05c294d4fe69c623bdef83  test_tree/nysubfil.txt
EOF

echo --- Test ignore files
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
mkdir test_tree || { echo "Couldn't create test_tree dir"; exit 1; }
REPO_PATH=$REPO $BOAR mksession IgnoreSession || { echo "Couldn't create ignore session"; exit 1; }
REPO_PATH=$REPO $BOAR setprop IgnoreSession ignore "*.ignore"
echo "contents1" >test_tree/included_file.txt
echo "contents2" >test_tree/ignored_file.txt.ignore
REPO_PATH=$REPO $BOAR import -w -m"Testing ignore" test_tree IgnoreSession || { echo "Couldn't import tree"; exit 1; }
(REPO_PATH=$REPO $BOAR list IgnoreSession 10 | grep included_file.txt) || { echo "List command for session did not contain expected file"; exit 1; }
(REPO_PATH=$REPO $BOAR list IgnoreSession 10 | grep ignored_file.txt.ignore) && { echo "List command for session DID contain an ignored file"; exit 1; }

echo --- Test include files
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
mkdir test_tree || { echo "Couldn't create test_tree dir"; exit 1; }
REPO_PATH=$REPO $BOAR mksession IncludeSession || { echo "Couldn't create include session"; exit 1; }
REPO_PATH=$REPO $BOAR setprop IncludeSession include "*.include"
echo "contents3" >test_tree/included_file.txt.include
echo "contents4" >test_tree/ignored_file.txt
REPO_PATH=$REPO $BOAR import -w -m"Testing include" test_tree IncludeSession || { echo "Couldn't import tree"; exit 1; }
(REPO_PATH=$REPO $BOAR list IncludeSession 14 | grep included_file.txt.include) || { echo "List command for session did not contain expected file"; exit 1; }
(REPO_PATH=$REPO $BOAR list IncludeSession 14 | grep ignored_file.txt) && { echo "List command for session DID contain an non-included file"; exit 1; }

echo --- Test combined ignore / include files
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
mkdir test_tree || { echo "Couldn't create test_tree dir"; exit 1; }
REPO_PATH=$REPO $BOAR mksession IncIgnSession || { echo "Couldn't create IncIgnSession session"; exit 1; }
REPO_PATH=$REPO $BOAR setprop IncIgnSession include "*include*"
REPO_PATH=$REPO $BOAR setprop IncIgnSession ignore "*ignore*"
echo "contents5" >test_tree/ignore-file.txt
echo "contents6" >test_tree/include-file.txt
echo "contents7" >test_tree/include-ignore-file.txt
REPO_PATH=$REPO $BOAR import -w -m"Testing include" test_tree IncIgnSession || { echo "Couldn't import tree"; exit 1; }
(REPO_PATH=$REPO $BOAR list IncIgnSession 19 | grep include-file.txt) || { echo "List command for session did not contain expected file"; exit 1; }
(REPO_PATH=$REPO $BOAR list IncIgnSession 19 | grep ignore-file.txt) && { echo "List command for session DID contain an non-included file"; exit 1; }
(REPO_PATH=$REPO $BOAR list IncIgnSession 19 | grep include-ignore-file.txt) && { echo "List command for session DID contain an non-included file"; exit 1; }

echo --- Test offset import / add file / status
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
mkdir test_tree || { echo "Couldn't create test_tree dir"; exit 1; }
REPO_PATH=$REPO $BOAR import -v -w test_tree MyTestSession/new_import || { echo "Couldn't import dir"; exit 1; }
(cd test_tree && $BOAR status) || { echo "Status command 1 failed"; exit 1; }
echo "Some new content" >test_tree/new_file.txt
(cd test_tree && $BOAR status) || { echo "Status command 2 failed"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }

echo --- Test successive imports
SESSION=SuccImp
mkdir test_tree || { echo "Couldn't create test_tree dir"; exit 1; }
echo "f1" >test_tree/file1.txt || { echo "Couldn't create file1"; exit 1; }
REPO_PATH=$REPO $BOAR mksession $SESSION || { echo "Couldn't create session"; exit 1; }
REPO_PATH=$REPO $BOAR import -W -v test_tree $SESSION/subdir || { echo "Couldn't import dir"; exit 1; }
rm test_tree/file1.txt || exit 1
echo "f2" >test_tree/file2.txt || { echo "Couldn't create file1"; exit 1; }
REPO_PATH=$REPO $BOAR import -W -v test_tree $SESSION/subdir || { echo "Couldn't import dir"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
REPO_PATH=$REPO $BOAR co $SESSION/subdir test_tree || { echo "Couldn't check out session"; exit 1; }
test -e test_tree/file1.txt || { echo "file1.txt does not exist in session"; exit 1; }
test -e test_tree/file2.txt || { echo "file2.txt does not exist in session"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }

echo --- Test offset co with unicode chars
mkdir test_tree || { echo "Couldn't create test_tree dir"; exit 1; }
mkdir test_tree/räksmörgåsar || { echo "Couldn't create test_tree dir"; exit 1; }
echo "En räksmörgås" >test_tree/räksmörgåsar/räksmörgås.txt || { echo "Couldn't create unicode file"; exit 1; }
REPO_PATH=$REPO $BOAR import -v -w test_tree MyTestSession || { echo "Couldn't import unicode dir"; exit 1; }
(cd test_tree && $BOAR status) || { echo "Status command failed"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
REPO_PATH=$REPO $BOAR co MyTestSession/räksmörgåsar test_tree || { echo "Couldn't check out unicode offset dir"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }

echo --- Test unicode session name
SESSION=Räksmörgås2
rm -r $SESSION
mkdir test_tree || { echo "Couldn't create test_tree dir"; exit 1; }
echo "Hello world" > test_tree/file1.txt || { echo "Couldn't create file"; exit 1; }
REPO_PATH=$REPO $BOAR mksession $SESSION || { echo "Couldn't create session"; exit 1; }
REPO_PATH=$REPO $BOAR import -v -w test_tree $SESSION || { echo "Couldn't import"; exit 1; }
(cd test_tree && $BOAR status) || { echo "Status command failed"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
REPO_PATH=$REPO $BOAR list $SESSION || { echo "Couldn't list session versions"; exit 1; }
ls
REPO_PATH=$REPO $BOAR co $SESSION || { echo "Couldn't check out session"; exit 1; }
(cd $SESSION && $BOAR status) || { echo "Status command failed"; exit 1; }
echo "Hello world2" >$SESSION/file2.txt || { echo "Couldn't create file2.txt"; exit 1; }
(cd $SESSION && $BOAR ci) || { echo "ci command failed"; exit 1; }
rm -r $SESSION || { echo "Couldn't remove session dir"; exit 1; }

echo --- Test ls command
SESSION=LsSession
mkdir test_tree || { echo "Couldn't create test_tree dir"; exit 1; }
mkdir test_tree/subdir || { echo "Couldn't create test_tree/subdir dir"; exit 1; }
echo "Hello world1" > test_tree/file1.txt || { echo "Couldn't create file"; exit 1; }
echo "Hello world2" > test_tree/subdir/file2.txt || { echo "Couldn't create file"; exit 1; }
echo "Hello world3" > test_tree/subdir/file3.txt || { echo "Couldn't create file"; exit 1; }
REPO_PATH=$REPO $BOAR mksession $SESSION || { echo "Couldn't create session"; exit 1; }
REPO_PATH=$REPO $BOAR import -v -w test_tree $SESSION || { echo "Couldn't import"; exit 1; }
(REPO_PATH=$REPO $BOAR ls | grep $SESSION) || { echo "Didn't find current session in session list"; exit 1; }
REPO_PATH=$REPO $BOAR ls $SESSION | grep -v Finished >lsoutput.txt || { echo "Couldn't ls session"; exit 1; }
echo "--" >> lsoutput.txt
REPO_PATH=$REPO $BOAR ls $SESSION/file1.txt | grep -v Finished >>lsoutput.txt || { echo "Couldn't ls session"; exit 1; }
echo "--" >> lsoutput.txt
REPO_PATH=$REPO $BOAR ls $SESSION/subdir | grep -v Finished >>lsoutput.txt || { echo "Couldn't ls session"; exit 1; }
echo "--" >> lsoutput.txt
REPO_PATH=$REPO $BOAR ls -v $SESSION/subdir | grep -v Finished >>lsoutput.txt || { echo "Couldn't ls session"; exit 1; }
REPO_PATH=$REPO $BOAR ls $SESSION/nonexisting && { echo "ls of non-existing dir succeeded (should fail)"; exit 1; }
diff lsoutput.txt - <<EOF || { echo "Differences in output found"; exit 1; }
file1.txt
subdir/
--
file1.txt
--
file2.txt
file3.txt
--
file2.txt 1kB
file3.txt 1kB
EOF
rm lsoutput.txt
rm -r test_tree || { echo "Couldn't remove test_tree"; exit 1; }

echo --- Test verify
REPO_PATH=$REPO $BOAR verify || { echo "Couldn't verify repo"; exit 1; }

echo --- Test repo cloning
$BOAR clone $REPO $CLONE || { echo "Couldn't clone repo"; exit 1; }
$BOAR diffrepo $REPO $CLONE || { echo "Some differences where found in cloned repo"; exit 1; }
rm -r $CLONE || { echo "Couldn't remove cloned repo"; exit 1; }

echo --- Test read-only repo
$BOAR clone $REPO $CLONE || { echo "Couldn't clone repo"; exit 1; }
chmod -R a-w $CLONE || { echo "Couldn't make clone read-only"; exit 1; }
REPO_PATH=$CLONE $BOAR ls || { echo "Couldn't list read-only repo"; exit 1; }
REPO_PATH=$CLONE $BOAR co MyTestSession test_tree || { echo "Couldn't check out test tree from read-only repo"; exit 1; }
echo "Hello everybody" > test_tree/read_only_hello.txt
(cd test_tree && $BOAR ci) && { echo "Check-in to read-only repo succeeded unexpectedly"; exit 1; }
chmod -R u+w $CLONE || { echo "Couldn't make clone writable"; exit 1; }
rm -r $CLONE || { echo "Couldn't remove cloned repo"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test_tree"; exit 1; }

echo --- Test repo cloning with duplicate files in a new session
mkdir test_tree || { echo "Couldn't create test tree"; exit 1; }
echo "Identical Content" >test_tree/file1.txt || { echo "Couldn't create file1.txt"; exit 1; }
echo "Identical Content" >test_tree/file2.txt || { echo "Couldn't create file2.txt"; exit 1; }
REPO_PATH=$REPO $BOAR mksession MyCloneTest || { echo "Couldn't create session"; exit 1; }
REPO_PATH=$REPO $BOAR import -W -v test_tree MyCloneTest || { echo "Couldn't import tree"; exit 1; }
$BOAR clone $REPO $CLONE || { echo "Couldn't clone repo"; exit 1; }
$BOAR diffrepo $REPO $CLONE || { echo "Some differences where found in cloned repo"; exit 1; }
rm -r $CLONE || { echo "Couldn't remove cloned repo"; exit 1; }

echo --- Test boarmount
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
REPO_PATH=$REPO $BOAR mksession BoarMount || { echo "Couldn't create boarmount session"; exit 1; }
REPO_PATH=$REPO $BOAR co BoarMount test_tree || { echo "Couldn't co boarmount session"; exit 1; }
tar -xvzf test_tree.tar.gz || { echo "Couldn't create test tree for boarmount"; exit 1; }
md5sum -c test_tree.md5 || { echo "Test tree was corrupt before checking in"; exit 1; }
(cd test_tree && REPO_PATH=$REPO $BOAR ci) || { echo "Couldn't ci boarmount session"; exit 1; }
rm -r test_tree || { echo "Couldn't remove test tree"; exit 1; }
mkdir test_tree || { echo "Couldn't create test_tree dir for mounting"; exit 1; }
$BOARMOUNT $REPO BoarMount test_tree || { echo "Couldn't mount session"; exit 1; }
(mount -l -t fuse.boarmount | grep ~+/test_tree) || { echo "Mounted session does not seem to really be mounted"; exit 1; }
[ `find test_tree|grep -c .` -eq 9 ] || { echo "Mounted tree does not contain expected number of files"; fusermount -u test_tree; exit 1; }
md5sum -c test_tree.md5 || { echo "Mounted session was corrupt"; fusermount -u test_tree; exit 1; }
fusermount -u test_tree

rm -r $REPO test_tree
echo "All tests completed ok!"
