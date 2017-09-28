#!/bin/bash/env python

# This script imports the necessary layers for calculating EEMT in the QGIS Python Console
from osgeo import gdal
from osgeo import osr
from PyQt4.QtCore import QFileInfo,QSettings
from qgis.core import QgsRasterLayer, QgsCoordinateReferenceSystem
from qgis.analysis import QgsRasterCalculator, QgsRasterCalculatorEntry
import processing,math,os,sys

#  User must set working directory and the filename of the DEM here before executing run
# Set the working directory for the input data
input_Dir = {PWD}

# Set the output directory for the products
output_Dir = input_Dir + '/hand_run/'

os.mkdir(output_Dir, 0755)

dem_filename = 'dem.tif'

# GDAL import DEM to read the projection
# dem=raster
# e.g. dem = 'dem_10m.tif'
dem = gdal.Open(os.path.join(input_Dir,dem_filename))

gt = dem.GetGeoTransform()
xorigin, xcellsize, xrotation, yorigion, yrotation, ycellsize = gt
# Get and Print Projection Information
projInfo=dem .GetProjection()
print projInfo

demLayer  = QgsRasterLayer(os.path.join(input_Dir,dem_filename), "dem")
if not demLayer.isValid(): print "DEM Layer failed to load!"

# Load raster layer into canvas
QgsMapLayerRegistry.instance().addMapLayer(demLayer)
 
# Print Extent of the DEM layer (for use with raster calculator)
print demLayer.extent().xMinimum(), demLayer.extent().xMaximum()
print demLayer.extent().yMinimum(), demLayer.extent().yMaximum()
print demLayer.width(), demLayer.height()
name = demLayer.name()
print name
bands = demLayer.bandCount()
print bands

