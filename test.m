clear;
clc;
close all;

rosshutdown;
rosinit;

%--------add paths for functions in other folders---------
add_paths();


subscribe_scan();
global scan
global scan2
disp(scan);
disp(scan2);
