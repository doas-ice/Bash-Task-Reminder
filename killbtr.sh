#!/usr/bin/env bash
echo $(cat btrserverpid)
sleep 3s
kill $(cat btrserverpid)
sleep 3s
