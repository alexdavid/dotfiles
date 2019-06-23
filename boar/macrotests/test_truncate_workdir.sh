# Test that a workdir belonging to a deleted snapshot works as
# expected.
set -e

$BOAR mkrepo TESTREPO || exit 1
touch TESTREPO/ENABLE_PERMANENT_ERASE || exit 1
$BOAR mksession --repo=TESTREPO TestSession || exit 1
$BOAR --repo=TESTREPO co TestSession || exit 1

cat >workdir_original_contents.txt <<EOF
repo_deleted.txt:original 3
repo_modified.txt:original 2
unchanged.txt:original 1
wd_modified.txt:wd locally modified
EOF

cd TestSession || exit 1
echo "original 1" >unchanged.txt || exit 1     # Unchanged
echo "original 2" >repo_modified.txt || exit 1 # Modified in a later commit from another workdir
echo "original 3" >repo_deleted.txt || exit 1  # Deleted in a later commit from another workdir
echo "original 4" >wd_modified.txt || exit 1   # Modified in workdir after commit
echo "original 5" >wd_deleted.txt || exit 1    # Deleted in workdir after commit
$BOAR ci || exit 1
echo "wd locally modified" >wd_modified.txt || exit 1
rm wd_deleted.txt || exit 1
cd ..

(cd TestSession && grep . *.txt) >output.txt || exit 1
txtmatch.py workdir_original_contents.txt output.txt || { echo "Unexpected workdir initial contents"; exit 1; }

$BOAR --repo=TESTREPO co TestSession TestSessionModify || exit 1
cd TestSessionModify
echo "modified" >repo_modified.txt || exit 1
rm repo_deleted.txt || exit 1
$BOAR ci || exit 1
cd ..
(cd TestSession && $BOAR info | grep "Snapshot id: 2") || { echo "Unexpected revision"; exit 1; }

$BOAR --repo=TESTREPO truncate TestSession || exit 1

cat >expected.txt <<EOF
[1, null, "__deleted", "d41d8cd98f00b204e9800998ecf8427e", null, true]
[2, null, "__deleted", "d41d8cd98f00b204e9800998ecf8427e", null, true]
[3, null, "__deleted", "d41d8cd98f00b204e9800998ecf8427e", null, true]
[4, null, "TestSession", "5802b36c54f7136ce0a140ca7b946783", null, false]
!Finished in .* seconds
EOF
$BOAR --repo=TESTREPO list --dump >output.txt 2>&1 || { echo "Dump failed"; exit 1; }
txtmatch.py expected.txt output.txt || { echo "Output mismatch at line $LINENO"; exit 1; }


cat >expected.txt <<EOF
!Repository: .*/TESTREPO
Session / Path: TestSession
Snapshot id: 2
!Workdir root: .*/TestSession
!Finished in .* seconds
EOF
(cd TestSession && $BOAR info 2>&1) >output.txt || { echo "Info failed"; exit 1; }
txtmatch.py expected.txt output.txt || { echo "Output mismatch at line $LINENO"; exit 1; }

cat >expected.txt <<EOF
ERROR: The current snapshot has been deleted in the repository.
!Finished in .* seconds
EOF
(cd TestSession && $BOAR status -q 2>&1) >output.txt && { cat output.txt; echo "Status for deleted snapshot should fail"; exit 1; }
txtmatch.py expected.txt output.txt || { echo "Output mismatch at line $LINENO"; exit 1; }

cat >expected_update_output.txt <<EOF
Skipping update of modified file repo_modified.txt
Updating: wd_deleted.txt
Skipping update of modified file wd_modified.txt
WARNING: Because the old workdir revision was deleted, the update command was
         unable to detect changes accurately. Make sure the workdir does not
         contain out of date data before you commit.
Workdir now at revision 4
!Finished in .* seconds
EOF
(cd TestSession && $BOAR update -q 2>&1) >update_result.txt || { echo "Update failed"; exit 1; }
txtmatch.py expected_update_output.txt update_result.txt || { echo "Output mismatch at line $LINENO"; exit 1; }

# All the files should still be as in the original workdir, except that
# wd_deleted.txt should be restored.
cat >workdir_updated_contents.txt <<EOF
repo_deleted.txt:original 3
repo_modified.txt:original 2
unchanged.txt:original 1
wd_deleted.txt:original 5
wd_modified.txt:wd locally modified
EOF
(cd TestSession && grep . *.txt) >workdir_after_update.txt || { echo "Grep failed"; exit 1; }
txtmatch.py workdir_updated_contents.txt workdir_after_update.txt || { echo "Unexpected workdir contents after update"; exit 1; }

cat >expected_workdir_status.txt <<EOF
A repo_deleted.txt
M repo_modified.txt
  unchanged.txt
  wd_deleted.txt
M wd_modified.txt
!Finished in .* seconds
EOF
(cd TestSession && $BOAR status -vq) >output.txt || { echo "Status failed"; exit 1; }
txtmatch.py expected_workdir_status.txt output.txt || { echo "Unexpected workdir status after update"; exit 1; }
(cd TestSession && $BOAR info | grep "Snapshot id: 4") || { echo "Unexpected revision"; exit 1; }

rm -r TestSession || exit 1 # To avoid mistakes in the rest of the code

echo "--- Test up-to-date workdir"
cat >workdir_uptodate_contents.txt <<EOF
repo_modified.txt:modified
unchanged.txt:original 1
wd_deleted.txt:original 5
wd_modified.txt:original 4
EOF

(cd TestSessionModify && grep . *.txt) >output.txt || exit 1
txtmatch.py workdir_uptodate_contents.txt output.txt || { echo "Unexpected uptodate workdir initial contents"; exit 1; }

(cd TestSessionModify && $BOAR info | grep "Snapshot id: 3") || { echo "Unexpected revision"; exit 1; }

cat >expected_uptodate_status.txt <<EOF
ERROR: The current snapshot has been deleted in the repository.
!Finished in .* seconds
EOF
(cd TestSessionModify && $BOAR status -q 2>&1) >output.txt && { cat output.txt; echo "Status for deleted snapshot should fail"; exit 1; }
txtmatch.py expected.txt output.txt || { echo "Output mismatch at line $LINENO"; exit 1; }


cat >expected_uptodate_update.txt <<EOF
Workdir now at revision 4
!Finished in .* seconds
EOF
(cd TestSessionModify && $BOAR update -q 2>&1 ) >output.txt || { echo "Status failed"; exit 1; }
txtmatch.py expected_uptodate_update.txt output.txt || { echo "Unexpected uptodate workdir update output"; exit 1; }
(cd TestSessionModify && $BOAR info | grep "Snapshot id: 4") || { echo "Unexpected revision"; exit 1; }


exit 0 # All is well
