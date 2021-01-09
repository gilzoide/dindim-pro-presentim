#!/bin/sh

pushd build

zip Dindim_pro_presentim_windows Dindim_pro_presentim_windows.exe Dindim_pro_presentim_windows.pck
zip Dindim_pro_presentim_linux_x86 Dindim_pro_presentim_linux.x86 Dindim_pro_presentim_linux.pck
zip Dindim_pro_presentim_linux_x86_64 Dindim_pro_presentim_linux.x86_64 Dindim_pro_presentim_linux.pck
zip Dindim_pro_presentim_web -j web/*

popd