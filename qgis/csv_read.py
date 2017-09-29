import csv

gps_locations = csv.reader(open("/home/tyson_swetnam/Downloads/bighorns/CPNWR_DBS_Locs.csv"), delimiter=",")

header = gps_locations.next()

print(header)

latIndex = header.index('lat')
longIndex = header.index('long')
hourIndex = header.index('hour')
julianIndex = header.index("julian")

coordList = []

for row in gps_locations:
	lat = row[latIndex]
	long = row[longIndex]
	hour = row[hourIndex]
	julian = row[julianIndex]
	coordList.append([lat,long])

from osgeo import gdal

driver = gdal.GetDriverByName('GTiff')

###

for julian in gps_locations
    for hour in gps_locations

filename = '~/bighorns/beam_rad_%s_day%s.tif' % (hour, julian) 
dataset = gdal.Open(filename)
band = dataset.GetRasterBand(1)

cols = dataset.RasterXSize
rows = dataset.RasterYSize

transform = dataset.GetGeoTransform()

xOrigin = transform[0]
yOrigin = transform[3]
pixelWidth = transform[1]
pixelHeight = -transform[5]

data = band.ReadAsArray(0, 0, cols, rows)

points_list = [ ] #list of X,Y coordinates

for point in coordList:
    col = int((point[0] - xOrigin) / pixelWidth)
    row = int((yOrigin - point[1] ) / pixelHeight)

    print row,col, data[row][col]

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
