#!/bin/bash
btrfs balance --full-balance start /
btrfs filesystem defragment -r /
