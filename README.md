# TFMrobotica

**<h2>Objetivo</h2>**

Hacer un sistema multirobot usando ROS y matlab que permita a dos turtlebots realizar tareas de forma conjunta

**<h2>Desarrollo</h2>**

- <h3>Trabajo para septiembre</h3>

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/doing.png" alt="alt text" width="25" height="25">  Tener un state of the art (repo: https://github.com/err8029/TFM_stateOfTheArt)

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/doing.png" alt="alt text" width="25" height="25">  Acabar el metodo de deteccion de colisiones con otros robots, usar CV

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/no.png" alt="alt text" width="25" height="25">  Mejorar el planificador, en vez de A* usar RRT o fast marching

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/no.png" alt="alt text" width="25" height="25">  Mejorar el tratamiento del mapa geometrico(transformada de hough)

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/yes.png" alt="alt text" width="25" height="25">  Implementar metodos de CV para deteccion del otro robot
   
   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/no.png" alt="alt text" width="25" height="25"> Elaboración de un mapa semantico

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/no.png" alt="alt text" width="25" height="25">  En vez de readCartesian() usar otra función para leer el laser. Encontrarla o implementarla

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/no.png" alt="alt text" width="25" height="25">  Ver que partes se pueden pasar a c++ para implementación en los robots reales

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/yes.png" alt="alt text" width="25" height="25">  Introducir objetos de mas complejidad en el mapa para analizar como los ven los robots
   
   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/yes.png" alt="alt text" width="25" height="25">  Mejorar el codigo, eliminando las variables globales y estructurandolo en clases y objetos

- <h3> Cosas de más </h3>

   - Tener en mente la estructura del tfm (idioma: English)
      - Portada
      - Intro
      - State of the art
      - Diseño del programa
      - Resultados (numericos preferibemente)
      - Experimentos
      - Concusiones
   
   - Tener en mente que exerimentos se quieren para la arte experimental
   
   - Testear en os robots reales

**<h2>Estado actual</h2>**

Programa con matlab para poder teleoperar, planificar con dos turtlebots (con GUI o teclado) en gazebo y recibir la imagen de su webcam y mapear a la vez

- <h3> Interfaz principal </h3>

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/GUI_main.png" alt="alt text" width="600" height="400">

- <h3> Ventana de mapeado </h3>

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/Mapping.png" alt="alt text" width="400" height="400">

- <h3> Panel de control de velocidades </h3>

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/control_GUI.png" alt="alt text" width="500" height="400">

- <h3> Mapa 3D en Gazebo </h3>

   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/gazebo.png" alt="alt text" width="500" height="400">
   
- <h3> Detector de turtlebots con SVM </h3>
   
   - Test image rank
   <p> 
   </p>
   
   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/linearSVM_test_rank.jpg" alt="alt text" width="500" height="400">
   
   - Accuracy of the test
   <p>  
   </p>
   
   <img src="https://github.com/err8029/TFMrobotica/blob/master/img/img_readme/linearSVM_test.jpg" alt="alt text" width="500" height="400">
