# new-profile-gen

This directory generates new firefox profiles with a base set of settings & userchrome.

### To generate a new profile:

```shell
./generate /path/to/new/profile "Profile Name" "#ff0000"
```

### To generate a new search.json.mozlz4 from search.json (requires python-lz4):

```shell
jq -c < search.json | python \
  -c "import lz4.block as lz4; import sys; import os; os.fdopen(sys.stdout.fileno(), 'wb').write(b'mozLz40\0' + lz4.compress(sys.stdin.read().encode('utf-8')))" \
  > search.json.mozlz4
```
