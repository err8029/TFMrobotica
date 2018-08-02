#!/bin/sh

#remove a previous map if it exists
FILE="random.world"
if [-f $FILE]; then
rm random.world
fi

#create the new map from the csv
sudo ./gazebo-map-from-csv.py

#copy the generated files to the ros dir
sudo cp kobuki_args.launch.xml /opt/ros/kinetic/share/turtlebot_gazebo/launch/includes
sudo cp random.world /opt/ros/kinetic/share/turtlebot_gazebo/worlds
sudo cp random.launch /opt/ros/kinetic/share/turtlebot_gazebo/launch

#launching the new 3d map
#roslaunch random.launch
