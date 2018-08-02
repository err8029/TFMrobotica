#!/usr/bin/env python

# Authors: Juan G Victores
# CopyPolicy: released under the terms of the LGPLv2.1
# URL: https://github.com/roboticslab-uc3m/gazebo-tools

from lxml import etree
from shutil import copyfile

#-- copy materials
dst="/usr/share/gazebo-7/media/materials/scripts/repeated.material"
src="materials/scripts/repeated.material"
copyfile(src,dst)

#-- copy textures
dst="/usr/share/gazebo-7/media/materials/textures/seamless_texture.png"
src="materials/textures/seamless_texture.png"
copyfile(src,dst)
dst="/usr/share/gazebo-7/media/materials/textures/wood2.jpg"
src="materials/textures/wood2.jpg"
copyfile(src,dst)
dst="/usr/share/gazebo-7/media/materials/textures/wood3.jpg"
src="materials/textures/wood3.jpg"
copyfile(src,dst)
dst="/usr/share/gazebo-7/media/materials/textures/wood4.jpg"
src="materials/textures/wood4.jpg"
copyfile(src,dst)
dst="/usr/share/gazebo-7/media/materials/textures/sofa.jpg"
src="materials/textures/sofa.jpg"
copyfile(src,dst)

#-- copy meshes
dst="/usr/share/gazebo-7/media/door_open.dae"
src="meshes/door_open.dae"
copyfile(src,dst)
dst="/usr/share/gazebo-7/media/Wood_Table.dae"
src="meshes/Wood_Table.dae"
copyfile(src,dst)
dst="/usr/share/gazebo-7/media/Bed.dae"
src="meshes/Bed.dae"
copyfile(src,dst)
dst="/usr/share/gazebo-7/media/chair.dae"
src="meshes/chair.dae"
copyfile(src,dst)
dst="/usr/share/gazebo-7/media/sofa.dae"
src="meshes/sofa.dae"
copyfile(src,dst)

#-- User variables
boxHeight = 2.5
inFileStr = 'random.csv'

resolution = 1.0  # Just to make similar to MATLAB [pixel/meter]
meterPerPixel = 1 / resolution  # [meter/pixel]

#-- Program
from numpy import genfromtxt
inFile = genfromtxt(inFileStr, delimiter=',')
print inFile

nX = inFile.shape[0]
nY = inFile.shape[1]
print "lines = X =",inFile.shape[0]
print "columns = Y =",inFile.shape[1]

#-- Default to X=rows,Y=columns. Uncomment the next 3 lines to transpose.
# print "transposing"
# from numpy import transpose
# inFile = transpose(inFile)

Ez = boxHeight

Ex = meterPerPixel
Ey = meterPerPixel

sdf = etree.Element("sdf", version="1.4")
world = etree.SubElement(sdf, "world", name="default")
light = etree.SubElement(world, "light", name="sun", type="directional")
cast_shadows = etree.SubElement(light, "cast_shadows").text="1"
diffuse = etree.SubElement(light, "diffuse").text="0.8 0.8 0.8 1"
specular = etree.SubElement(light, "specular").text="0.1 0.1 0.1 1"
attenuation = etree.SubElement(light, "attenuation")
_range = etree.SubElement(attenuation, "range").text="1000"
constant = etree.SubElement(attenuation, "constant").text="0.9"
linear = etree.SubElement(attenuation, "linear").text="0.01"
quadratic = etree.SubElement(attenuation, "quadratic").text="0.001"
direction = etree.SubElement(light, "direction").text="-0.5 0.5 -1"

#-- Create Floor
floorEx = Ex * nX
floorEy = Ey * nY
floorEz = boxHeight / 8.0  # arbitrary

model = etree.SubElement(world, "model", name="floor")
pose = etree.SubElement(model, "pose").text=str(floorEx/2.0)+" "+str(floorEy/2.0)+" "+str(-floorEz/2.0)+" 0 0 0"
static = etree.SubElement(model, "static").text="true"
link = etree.SubElement(model, "link", name="link")
collision = etree.SubElement(link, "collision", name="collision")
geometry = etree.SubElement(collision, "geometry")
box = etree.SubElement(geometry, "box")
size = etree.SubElement(box, "size").text=str(floorEx)+" "+ str(floorEy)+" "+str(floorEz)
visual = etree.SubElement(link, "visual", name="visual")

material = etree.SubElement(visual, "material")

script= etree.SubElement(material, "script")
uri= etree.SubElement(script, "uri").text="file://media/materials/scripts/Gazebo.material"
name= etree.SubElement(script, "name").text="Gazebo/Wood"

geometry = etree.SubElement(visual, "geometry")
box = etree.SubElement(geometry, "box")
size = etree.SubElement(box, "size").text=str(floorEx)+" "+ str(floorEy)+" "+str(floorEz)

#-- Create Walls
for iX in range(nX):
    #print "iX:",iX
    for iY in range(nY):
        #print "* iY:",iY

        #-- Skip box if map indicates a 0
        if inFile[iX][iY] == 0:
        	continue

	#-- Open vertical door 2x1
	if inFile[iX][iY] == 2:
		x = Ex + iX*meterPerPixel
        	y = Ey/2.0 + iY*meterPerPixel
        	z = Ez/2.0  # Add this to raise to floor level (centered by default)

		#pose
		model = etree.SubElement(world, "model", name="door_"+str(iX)+"_"+str(iY))
        	pose = etree.SubElement(model, "pose").text=str(x)+" "+str(y)+" "+"0"+" 0 0 0"
        	static = etree.SubElement(model, "static").text="true"
        	link = etree.SubElement(model, "link", name="body")
		
		#collision for the frame
		collision = etree.SubElement(link, "collision", name="collision")
		pose = etree.SubElement(collision, "pose").text=str(0.9)+" "+str(0)+" "+"0"+" 0 0 0"
		geometry = etree.SubElement(collision, "geometry")
		box = etree.SubElement(geometry, "box")
		size = etree.SubElement(box, "size").text=str(Ex*0.2)+" "+ str(0.2*Ey)+" "+str(Ez)

		#collision for the blade
		collision = etree.SubElement(link, "collision", name="collision")
		pose = etree.SubElement(collision, "pose").text=str(-0.9)+" "+str(-0.9)+" "+"0"+" 0 0 0"
		geometry = etree.SubElement(collision, "geometry")
		box = etree.SubElement(geometry, "box")
		size = etree.SubElement(box, "size").text=str(Ex*0.15)+" "+ str(2.25*Ey)+" "+str(Ez)

		#3d model door
		visual = etree.SubElement(link, "visual", name="visual")
        	geometry = etree.SubElement(visual, "geometry")
		mesh = etree.SubElement(geometry,"mesh")
		uri = etree.SubElement(mesh,"uri").text="file://media/door_open.dae"
        	scale = etree.SubElement(mesh, "scale").text="2"+" "+ "2"+" "+"1.25"

	#-- Open horizontal door 1x2
	if inFile[iX][iY] == 3:
		x = Ex + iX*meterPerPixel
        	y = Ey/2.0 + iY*meterPerPixel
        	z = Ez/2.0  # Add this to raise to floor level (centered by default)

		#pose
		model = etree.SubElement(world, "model", name="door_"+str(iX)+"_"+str(iY))
        	pose = etree.SubElement(model, "pose").text=str(x-0.5)+" "+str(y+0.5)+" "+"0"+" 0 0 1.557"
        	static = etree.SubElement(model, "static").text="true"
        	link = etree.SubElement(model, "link", name="body")

		#collision for the frame
		collision = etree.SubElement(link, "collision", name="collision")
		pose = etree.SubElement(collision, "pose").text=str(0.9)+" "+str(0)+" "+"0"+" 0 0 0"
		geometry = etree.SubElement(collision, "geometry")
		box = etree.SubElement(geometry, "box")
		size = etree.SubElement(box, "size").text=str(Ex*0.2)+" "+ str(0.2*Ey)+" "+str(Ez)

		#collision for the blade
		collision = etree.SubElement(link, "collision", name="collision")
		pose = etree.SubElement(collision, "pose").text=str(-0.9)+" "+str(-0.9)+" "+"0"+" 0 0 0"
		geometry = etree.SubElement(collision, "geometry")
		box = etree.SubElement(geometry, "box")
		size = etree.SubElement(box, "size").text=str(Ex*0.15)+" "+ str(2.25*Ey)+" "+str(Ez)

		#3d model door
		visual = etree.SubElement(link, "visual", name="visual")
        	geometry = etree.SubElement(visual, "geometry")
		mesh = etree.SubElement(geometry,"mesh")
		uri = etree.SubElement(mesh,"uri").text="file://media/door_open.dae"
        	scale = etree.SubElement(mesh, "scale").text="2"+" "+ "2"+" "+"1.25"
	#table 1x1
	if inFile[iX][iY] == 4:
		x = Ex + iX*meterPerPixel
        	y = Ey/2.0 + iY*meterPerPixel
        	z = Ez/2.0  # Add this to raise to floor level (centered by default)

		#pose
		model = etree.SubElement(world, "model", name="table_"+str(iX)+"_"+str(iY))
        	pose = etree.SubElement(model, "pose").text=str(x-0.5)+" "+str(y)+" "+"0"+" 0 0 0"
        	static = etree.SubElement(model, "static").text="true"
        	link = etree.SubElement(model, "link", name="body")

		#collision
		collision = etree.SubElement(link, "collision", name="collision")
		geometry = etree.SubElement(collision, "geometry")
		box = etree.SubElement(geometry, "box")
		size = etree.SubElement(box, "size").text=str(Ex)+" "+ str(Ey)+" "+str(Ez)

		#3d model table
		visual = etree.SubElement(link, "visual", name="visual")

		material = etree.SubElement(visual, "material")
		script= etree.SubElement(material, "script")
		uri= etree.SubElement(script, "uri").text="file://media/materials/scripts/repeated.material"
		name= etree.SubElement(script, "name").text="Repeated/wood"

        	geometry = etree.SubElement(visual, "geometry")
		mesh = etree.SubElement(geometry,"mesh")
		uri = etree.SubElement(mesh,"uri").text="file://media/Wood_Table.dae"
        	scale = etree.SubElement(mesh, "scale").text="1.5"+" "+ "1.5"+" "+"1.5"
	#chair 1x1
	if inFile[iX][iY] == 7:
		x = Ex + iX*meterPerPixel
        	y = Ey/2.0 + iY*meterPerPixel
        	z = Ez/2.0  # Add this to raise to floor level (centered by default)

		#pose
		model = etree.SubElement(world, "model", name="table_"+str(iX)+"_"+str(iY))
        	pose = etree.SubElement(model, "pose").text=str(x-0.75)+" "+str(y)+" "+"0"+" 0 0 0"
        	static = etree.SubElement(model, "static").text="true"
        	link = etree.SubElement(model, "link", name="body")

		#collision
		collision = etree.SubElement(link, "collision", name="collision")
		geometry = etree.SubElement(collision, "geometry")
		box = etree.SubElement(geometry, "box")
		size = etree.SubElement(box, "size").text=str(Ex)+" "+ str(Ey)+" "+str(Ez)

		#3d model table
		visual = etree.SubElement(link, "visual", name="visual")

		material = etree.SubElement(visual, "material")
		script= etree.SubElement(material, "script")
		uri= etree.SubElement(script, "uri").text="file://media/materials/scripts/repeated.material"
		name= etree.SubElement(script, "name").text="Repeated/wood3"

        	geometry = etree.SubElement(visual, "geometry")
		mesh = etree.SubElement(geometry,"mesh")
		uri = etree.SubElement(mesh,"uri").text="file://media/chair.dae"
        	scale = etree.SubElement(mesh, "scale").text="0.25"+" "+ "0.25"+" "+"0.35"
	#sofa 4x1
	if inFile[iX][iY] == 5:
		x = Ex + iX*meterPerPixel
        	y = Ey/2.0 + iY*meterPerPixel
        	z = Ez/2.0  # Add this to raise to floor level (centered by default)

		#pose
		model = etree.SubElement(world, "model", name="sofa_"+str(iX)+"_"+str(iY))
        	pose = etree.SubElement(model, "pose").text=str(x)+" "+str(y)+" "+"0"+" 0 0 -1.557"
        	static = etree.SubElement(model, "static").text="true"
        	link = etree.SubElement(model, "link", name="body")

		#collision
		collision = etree.SubElement(link, "collision", name="collision")
		geometry = etree.SubElement(collision, "geometry")
		box = etree.SubElement(geometry, "box")
		size = etree.SubElement(box, "size").text=str(Ex)+" "+ str(4*Ey)+" "+str(Ez)

		#3d model table
		visual = etree.SubElement(link, "visual", name="visual")

		material = etree.SubElement(visual, "material")
		script= etree.SubElement(material, "script")
		uri= etree.SubElement(script, "uri").text="file://media/materials/scripts/repeated.material"
		name= etree.SubElement(script, "name").text="Repeated/sofa"

        	geometry = etree.SubElement(visual, "geometry")
		mesh = etree.SubElement(geometry,"mesh")
		uri = etree.SubElement(mesh,"uri").text="file://media/sofa.dae"
		scale = etree.SubElement(mesh, "scale").text="0.5"+" "+ "0.8"+" "+"1"
	#bed 2x3
	if inFile[iX][iY] == 6:
		x = Ex + iX*meterPerPixel
        	y = Ey/2.0 + iY*meterPerPixel
        	z = Ez/2.0  # Add this to raise to floor level (centered by default)

		#pose
		model = etree.SubElement(world, "model", name="bed_"+str(iX)+"_"+str(iY))
        	pose = etree.SubElement(model, "pose").text=str(x)+" "+str(y+1)+" "+"0"+" 1.557 0 0"
        	static = etree.SubElement(model, "static").text="true"
        	link = etree.SubElement(model, "link", name="body")

		#collision
		collision = etree.SubElement(link, "collision", name="collision")
		geometry = etree.SubElement(collision, "geometry")
		box = etree.SubElement(geometry, "box")
		size = etree.SubElement(box, "size").text=str(2*Ex)+" "+ str(3*Ey)+" "+str(Ez)

		#3d model table
		visual = etree.SubElement(link, "visual", name="visual")

		material = etree.SubElement(visual, "material")
		script= etree.SubElement(material, "script")
		uri= etree.SubElement(script, "uri").text="file://media/materials/scripts/repeated.material"
		name= etree.SubElement(script, "name").text="Repeated/sofa"

        	geometry = etree.SubElement(visual, "geometry")
		mesh = etree.SubElement(geometry,"mesh")
		uri = etree.SubElement(mesh,"uri").text="file://media/Bed.dae"
		scale = etree.SubElement(mesh, "scale").text="0.36"+" "+ "0.36"+" "+"0.36"
	#box 1x1
        if inFile[iX][iY] == 1:

		#-- Add E___/2.0 to each to force begin at 0,0,0 (centered by default)
		x = Ex/2.0 + iX*meterPerPixel
		y = Ey/2.0 + iY*meterPerPixel
		z = Ez/2.0  # Add this to raise to floor level (centered by default)

		#-- Create box
		model = etree.SubElement(world, "model", name="box_"+str(iX)+"_"+str(iY))
		pose = etree.SubElement(model, "pose").text=str(x)+" "+str(y)+" "+str(z)+" 0 0 0"
		static = etree.SubElement(model, "static").text="true"
		link = etree.SubElement(model, "link", name="link")
		collision = etree.SubElement(link, "collision", name="collision")
		geometry = etree.SubElement(collision, "geometry")
		box = etree.SubElement(geometry, "box")
		size = etree.SubElement(box, "size").text=str(Ex)+" "+ str(Ey)+" "+str(Ez)
		visual = etree.SubElement(link, "visual", name="body_visual")

	
		material = etree.SubElement(visual, "material")

		script= etree.SubElement(material, "script")
		uri= etree.SubElement(script, "uri").text="file://media/materials/scripts/repeated.material"
		name= etree.SubElement(script, "name").text="Repeated/seamless"

		#ambient = etree.SubElement(material, "ambient").text="0 0 0 1"
		#diffusive = etree.SubElement(material, "diffuse").text="0 0 0 1"
		#specular = etree.SubElement(material, "specular").text="0 0 0 0"
		#emissive = etree.SubElement(material, "emissive").text="0 1 0 1"

		geometry = etree.SubElement(visual, "geometry")
		box = etree.SubElement(geometry, "box")
		size = etree.SubElement(box, "size").text=str(Ex)+" "+ str(Ey)+" "+str(Ez)

myStr = etree.tostring(sdf, pretty_print=True)

outFile = open('random.world', 'w')
outFile.write(myStr)
outFile.close()
