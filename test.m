clear;
clc;
close all;

rosshutdown;
rosinit;

%subscribe in the necessary topics
subscribe_cams();

%pubishers
global vel_pub
global vel2_pub
vel_pub = rospublisher('/robot2/mobile_base/commands/velocity');
vel2_pub = rospublisher('/robot1/mobile_base/commands/velocity');

%unpack the messages
global img_sub
global img2_sub
cam1_msg=img_sub.LatestMessage;
cam2_msg=img2_sub.LatestMessage;

%create the figure
createfig();
global img1_handle
global img2_handle

%image robot 2
display_image(cam1_msg,img2_handle)
%image robot1
display_image(cam2_msg,img1_handle)

