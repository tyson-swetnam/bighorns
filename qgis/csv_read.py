import csv

# Load .csv and create arrays

with open('${PWD}/CPNWR_DBS_Locs.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    cases = []
    lats = []
    longs = []
    day = []
    hours = []
    
    for row in readCSV:
        case = row[0]
        lat = row[8]
        long = row[9]
        julian = row[13]
        hour = row[12]

        cases.append(case)
        lats.append(lat)
        longs.append(long)
        day.append(julian)
        hours.append(hour)

# Sample each row by its corresponding solar radiation raster

from osgeo import gdal,ogr
import struct

src_filename = '~/bighorns/%s_%s_globrad.tif' % (day,hour)
shp_filename = '/tmp/test.shp'

src_ds=gdal.Open(src_filename) 
gt=src_ds.GetGeoTransform()
rb=src_ds.GetRasterBand(1)

ds=ogr.Open(shp_filename)
lyr=ds.GetLayer()
for feat in lyr:
    geom = feat.GetGeometryRef()
    mx,my=geom.GetX(), geom.GetY()  #coord in map units

    #Convert from map to pixel coordinates.
    #Only works for geotransforms with no rotation.
    px = int((mx - gt[0]) / gt[1]) #x pixel
    py = int((my - gt[3]) / gt[5]) #y pixel

    intval=rb.ReadAsArray(px,py,1,1)
    print intval[0]  #intval is a numpy array, length=1 as we only asked for 1 pixel value
