#!/bin/bash

cd build && mvn clean install -Dmaven.test.skip=true
