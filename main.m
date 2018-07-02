clear;
clc;
close all;

rosshutdown;
rosinit;

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

%---------------wait for key press----------------------
set(hfig,'KeyPressFcn',@move);




