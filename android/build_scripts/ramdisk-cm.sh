#!/bin/bash
sudo mount -t ramfs none /home/jmurray/android/cm/out -o size=27G
sudo chown -R jmurray:jmurray /home/jmurray/android/cm/out
exit
