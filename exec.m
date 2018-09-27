clc
clear
close all
rosshutdown
rosinit

tic
GUI=GUIgenerator();
toc


%recursivity, one robot calls the other every time a movement is captured and so on 
%to change the key press function
set(GUI.hfig,'KeyPressFcn',@GUI.catch_key);