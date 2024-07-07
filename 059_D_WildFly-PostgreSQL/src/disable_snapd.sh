#!/usr/bin/env bash

systemctl | grep snap | cut -f 3 -d ' ' | xargs systemctl disable;
