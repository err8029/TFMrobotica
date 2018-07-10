clear;
clc;
close all;

rosshutdown;
rosinit;

%--------add paths for functions in other folders---------
add_paths();

%---------------init enable cam ctrl vars--------------------
global enable1
global enable2
enable1=true;
enable2=true;

%-------------------subscribers---------------------------
subscribe_cams();
subscribe_odom();
subscribe_scan(); %really slow

%--------------------pubishers----------------------------
global vel_pub
global vel2_pub
vel_pub = rospublisher('/robot1/mobile_base/commands/velocity');
vel2_pub = rospublisher('/robot2/mobile_base/commands/velocity');

%---------------create the figure------------------------
global hfig
createfig();

%---------------init velocity-------------------------
global vel1
global vel2
global w1
global w2
vel1=0.3;
vel2=0.3;
w1=0.5;
w2=0.5;
%update speeds in GUI
speed_update();

%---------------wait for key press----------------------
%recursivity, one robot calls the other every time a movement is captured and so on 
%to change the key press function
set(hfig,'KeyPressFcn',@move);









