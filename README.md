# TFMrobotica

**Objetivo**

Hacer un sistema multirobot usando ROS y matlab que permita a dos turtlebots realizar tareas de forma conjunta

**Estado actual**

Programa con matlab para poder teleoperar, planificar con dos turtlebots (con GUI o teclado) en gazebo y recibir la imagen de su webcam y mapear a la vez

Interfaz principal
![alt text](https://github.com/err8029/TFMrobotica/blob/master/main_GUI.png)

Panel de control de velocidades
![alt text](https://github.com/err8029/TFMrobotica/blob/master/control_GUI.png)

Ventana de mapeado
![alt text](https://github.com/err8029/TFMrobotica/blob/master/mapping_GUI.png)

**Trabajo inmediato**

Que un robot tenga en cuenta a posicion del otro al planificar,intentar mejorar los tiempos de suscripcion al laser, slicer para el lookahead, control de la frecuencia de mapeado, mejor integración de la ventana de mapeado y probarlo en la realidad
