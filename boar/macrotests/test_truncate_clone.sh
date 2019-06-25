# Test that cloning of truncated repo works as expected

$BOAR mkrepo TESTREPO || exit 1
$BOAR mksession --repo=TESTREPO TestSession || exit 1
$BOAR --repo=TESTREPO co TestSession || exit 1
$BOAR mksession --repo=TESTREPO AnotherTestSession || exit 1
$BOAR --repo=TESTREPO co AnotherTestSession || exit 1

echo "Rev 2" >TestSession/r2.txt || exit 1
(cd TestSession && $BOAR ci -q) || exit 1

rm TestSession/r2.txt || exit 1
echo "Rev 3" >TestSession/r3.txt || exit 1
(cd TestSession && $BOAR ci -q) || exit 1

echo "Another file" >AnotherTestSession/another.txt || exit 1
(cd AnotherTestSession && $BOAR ci -q) || exit 1

rm TestSession/r3.txt || exit 1
echo "Rev 4" >TestSession/r4.txt || exit 1
(cd TestSession && $BOAR ci -q) || exit 1

echo "Yet another file" >AnotherTestSession/yet_another.txt || exit 1
rm AnotherTestSession/another.txt || exit 1
(cd AnotherTestSession && $BOAR ci -q) || exit 1

cp -an TESTREPO TESTREPO_truncated || exit 1
touch TESTREPO_truncated/ENABLE_PERMANENT_ERASE || exit 1


echo --- Verify that all snapshots exist before truncation
for snapshot in 1 2 3 4 5 6 7; do
    # Make sure that all expected snapshots exist before truncation
    test -e "TESTREPO_truncated/sessions/$snapshot" || { echo "Snapshot $snapshot should exist"; exit 1; }
done
test ! -e "TESTREPO_truncated/sessions/8" || { echo "Snapshot should not exist yet"; exit 1; }


$BOAR --repo=TESTREPO_truncated truncate TestSession || { echo "Truncation failed"; exit 1; }
$BOAR --repo=TESTREPO_truncated verify || { echo "Truncated repo failed verify"; exit 1; }
$BOAR clone TESTREPO_truncated TESTREPO_truncated_clone || { echo "Truncated cloning failed"; exit 1; }

cat >expected.txt <<EOF
[1, null, "__deleted", "d41d8cd98f00b204e9800998ecf8427e", null, true]
[2, null, "AnotherTestSession", "d41d8cd98f00b204e9800998ecf8427e", null, false]
[3, null, "__deleted", "d41d8cd98f00b204e9800998ecf8427e", null, true]
[4, null, "__deleted", "d41d8cd98f00b204e9800998ecf8427e", null, true]
[5, null, "AnotherTestSession", "0e997688909a2d27886dfdeaa627b560", null, false]
[6, null, "__deleted", "d41d8cd98f00b204e9800998ecf8427e", null, true]
[7, null, "AnotherTestSession", "31a44468d11cc4924b15c5d106410a63", null, false]
[8, null, "TestSession", "ed6b2754f96ba1e3c1cf10ab3e492b03", null, false]
!Finished in .* seconds
EOF

$BOAR --repo=TESTREPO_truncated_clone list -d >output.txt 2>&1 || { 
    cat output.txt; echo "Listing truncated clone failed"; exit 1; }
txtmatch.py expected.txt output.txt || { echo "Unexpected list result"; exit 1; }
$BOAR --repo=TESTREPO_truncated_clone verify || { echo "Truncated clone repo failed verify"; exit 1; }

echo "--- Test that deleted snapshots are deleted on the other side when cloning"

$BOAR clone TESTREPO TESTREPO_clone || { echo "Simple cloning failed"; exit 1; }

cat >expected_clone_error.txt <<EOF
ERROR: Source repo has deleted snapshots, but destination repo does not allow deletions
!Finished in .* seconds
EOF

$BOAR clone TESTREPO_truncated TESTREPO_clone >output.txt 2>&1 && { echo "Cloning with deletions to a repo without enabled deletions should fail"; exit 1; }
tail -2 output.txt >output-tail.txt
txtmatch.py expected_clone_error.txt output-tail.txt || exit 1

touch TESTREPO_clone/ENABLE_PERMANENT_ERASE || exit 1

ls TESTREPO_clone/tmp/mutex* && { echo "There is a forgotten mutex in TESTREPO_clone"; exit 1; }

$BOAR clone TESTREPO_truncated TESTREPO_clone || { echo "Cloning deletions failed"; exit 1; }

$BOAR --repo=TESTREPO_clone list -d >output.txt 2>&1 || { 
    cat output.txt; echo "Listing cloned repo with deletions failed"; exit 1; }
txtmatch.py expected.txt output.txt || { echo "Unexpected list result for repo with cloned deletions"; exit 1; }
$BOAR clone TESTREPO_truncated TESTREPO_clone || { echo "Cloning deletions for identical repo failed"; exit 1; }

exit 0
