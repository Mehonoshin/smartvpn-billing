#!/bin/bash
#
# Author:: Joshua Timberman <joshua@opscode.com>
#
# Copyright (c) 2013, Opscode, Inc. <legal@opscode.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This script is intended to be run directly by jenkins in a cookbook
# testing job.
#
# This script also does no error checking and may explode.

KITCHEN_DIR="${PWD}/.kitchen"
export GEM_HOME="~/.gem"
export PATH="~/.gem/bin:$PATH"

if [ ! -f $KITCHEN_DIR/prepared ]
then
    vagrant plugin install berkshelf-vagrant || exit 1
    gem install berkshelf || exit 1
    gem install kitchen-vagrant || exit 1
    gem install test-kitchen --pre || exit 1
    mkdir -p $KITCHEN_DIR
    touch $KITCHEN_DIR/prepared
fi

foodcritic -f ~FC007 . || exit 1
knife cookbook test -o .. $(basename $PWD) || exit 1
kitchen test
