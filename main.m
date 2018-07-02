clear;
clc;
close all;

rosshutdown;
rosinit;

%--------add paths for functions in other folders---------
add_paths();

%-------------------subscribers---------------------------
subscribe_cams();
subscribe_odom();

%--------------------pubishers----------------------------
global vel_pub
global vel2_pub
vel_pub = rospublisher('/robot1/mobile_base/commands/velocity');
vel2_pub = rospublisher('/robot2/mobile_base/commands/velocity');


%---------------create the figure------------------------
hfig = createfig();

%---------------init velocity-------------------------
global vel1
global vel2
global w1
global w2
vel1=0.5;
vel2=0.5;
w1=0.5;
w2=0.5;
%update speeds in GUI
speed_update();

%---------------wait for key press----------------------
%two keys at same time per robot
%waiting for robot 1
set(hfig,'KeyPressFcn',@move);
set(hfig,'KeyPressFcn',@move);
%waiting for robot 2
set(hfig,'KeyPressFcn',@move);
set(hfig,'KeyPressFcn',@move);



