#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Copyright 2011 Mats Ekberg
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from __future__ import with_statement
import sys
import os
import time
import random as random_module
import array
import hashlib

import posixpath

if __name__ == '__main__':
    boar_home = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    sys.path.insert(0, boar_home)

from common import md5sum, VERY_LARGE_NUMBER

allowed_chars = u" abcdefghijklmnpqrstuvwxyzåäöABCDEFGHIJKLMNPQRSTUVWXYZÅÄÖ_0123456789"

def get_random_filename(random, windows_compatible = False):
    result = ""
    for x in range(0, random.choice([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 21, 50, 200])):
        result += random.choice(allowed_chars)
    if windows_compatible:
        result = result.rstrip(". ") # Not allowed by most windows applications, including python
        if result == "":
            result = "x"
    return result

def lowercase(iterable):
    for s in iterable:
        yield s.lower()

class RandTree:
    def __init__(self, directory, use_windows_limits = False, max_path_length = VERY_LARGE_NUMBER):
        self.directory = os.path.abspath(directory)
        self.dirs = [""]
        self.rnd = random_module.Random(0)
        self.max_path_length = max_path_length
        self.files = {} # filename -> seed integer
        self.file_data = {} # seed -> file contents (cache)
        self.use_windows_limits = use_windows_limits

    def find_unused_filename(self, prefix = "", suffix = ""):
        for n in xrange(0, 100):
            candidate_path = self.__find_unused_filename(prefix, suffix)
            if len(candidate_path) <= self.max_path_length:
                return candidate_path
        raise Exception("Couldn't find a suitable filename within the given constraints")

    def has_filename(self, filename):
        if not self.use_windows_limits:
            return filename in self.files or filename in self.dirs
        return filename.lower() in lowercase(self.files) or filename.lower() in lowercase(self.dirs)

    def __find_unused_filename(self, prefix, suffix):
        path = self.rnd.choice(self.dirs)
        random_base = get_random_filename(self.rnd, windows_compatible = self.use_windows_limits)
        filename = posixpath.join(path, prefix + random_base + suffix)
        index = 0
        while self.has_filename(filename):
            index += 1
            filename = posixpath.join(path, prefix + random_base + str(index) + suffix)
        return filename

    def add_dirs(self, number_of_dirs):
        for n in xrange(number_of_dirs):            
            new_dir = self.find_unused_filename(prefix = "dir_")
            assert len(new_dir) <= self.max_path_length
            self.dirs.append(new_dir)

    def add_files(self, number_of_files):
        for n in xrange(number_of_files):
            new_file = self.find_unused_filename(prefix = "file_")
            assert len(new_file) <= self.max_path_length
            assert "\\" not in new_file
            assert not os.path.isabs(new_file)
            self.files[new_file] = self.rnd.randint(0, 2**32)
            self.__write_file(new_file)

    def __write_file(self, fn):
            assert not posixpath.isabs(fn)
            assert fn in self.files
            fullname = os.path.join(self.directory, fn)
            directory = os.path.dirname(fullname)
            if not os.path.exists(directory):
                os.makedirs(directory)
            assert os.path.isdir(directory)
            with open(fullname, "wb") as f:
                f.write(self.get_file_data(fn))

    def modify_files(self, number_of_files):
        assert number_of_files <= len(self.files)
        winners = self.rnd.sample(sorted(self.files), number_of_files)
        for fn in winners:
            self.files[fn] += 1
            self.__write_file(fn)

    def delete_files(self, number_of_files):
        assert number_of_files <= len(self.files)
        winners = self.rnd.sample(sorted(self.files), number_of_files)
        for fn in winners:
            del self.files[fn]
            fullname = os.path.join(self.directory, fn)
            os.remove(fullname)

    def get_file_data(self, fn):
        seed = self.files[fn]
        if seed not in self.file_data:
            random_module.seed(seed)
            size = random_module.randint(0, 2**17)
            bytes = [chr(x) for x in range(0, 256)]
            self.file_data[seed] = ''.join([random_module.choice(bytes) for i in xrange(size)])
        return self.file_data[seed]

    def fingerprint(self):
        md5 = hashlib.md5()
        sep = "!SEPARATOR!"
        for fn in sorted(self.files):
            md5.update(fn.replace("\\", "/").encode("utf-8"))
            md5.update(sep)
            md5.update(self.get_file_data(fn))
            md5.update(sep)
        return md5.hexdigest()

    def write_md5sum(self, destination, prefix = ""):
        with open(destination, "wb") as f:
            for fn in sorted(self.files):
                f.write(md5sum(self.get_file_data(fn)))
                f.write(" *")
                f.write(os.path.join(prefix, fn.encode("utf-8")))
                f.write(os.linesep)

assert list(lowercase({"Tjo": 1})) == ["tjo"]

"""
def main():
    r = RandTree("/tmp/TESTRAND", max_path_length = 50)
    r.add_dirs(5)
    r.add_files(100)

if __name__ == "__main__":
    main()
"""
