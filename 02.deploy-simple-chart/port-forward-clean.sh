#!/usr/bin/env bash

kill -9 `ps aux | grep 8443 | awk '{print $2}'`
