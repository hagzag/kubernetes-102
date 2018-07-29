#!/usr/bin/env bash
. port-forward-clean.sh
helm del --purge kubernetes-dashboard
