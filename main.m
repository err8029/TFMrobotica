clear;
clc;
close all;

rosshutdown;
rosinit;
tic
%--------add paths for functions in other folders---------
add_paths();

%---------------init enable cam ctrl vars--------------------
global enable1
global enable2
global enable_nav
global checker
enable1=true;
enable2=true;
enable_nav=true;%enable mapping and reactive
checker=false;%use checker as navigation way

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
global lookahead
global freq
vel1=0.2;
vel2=0.2;
w1=0.5;
w2=0.5;
lookahead=1.2;
freq=6;
%update speeds in GUI
speed_update();
toc
%---------------wait for key press----------------------
%recursivity, one robot calls the other every time a movement is captured and so on 
%to change the key press function
set(hfig,'KeyPressFcn',@move);









