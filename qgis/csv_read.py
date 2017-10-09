import csv


input_Dir = $PWD

gps_locations = csv.reader(open("/home/tswetnam/Downloads/bighorns/CPNWR_DBS_Locs.csv"), delimiter=",")

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

# Prepare to import rasters	
from osgeo import gdal
format = "GTiff"
driver = gdal.GetDriverByName( format )



for julian in gps_locations:
    for hour in gps_locations:
	# Flush data from memory
	dst_ds = None
	src_ds = None
	# load .tif
	beam_dst_ds = os.path.join(input_Dir,'beam_rad_%s_day%s.tif') % (hour, julian)
	beam_dst_dsLayer = QgsRasterLayer(beam_dst_ds, "beam_%s_day%s") % (hour, julian)
			  
# Loop through the .csv file and sample rasters by their cooresponding hour day
	
	beam_%s_day%s = '/home/tswetnam/Downloads/bighorns/beam_rad_%s_day%s.tif' % (hour, julian, hour, julian) 
	beam_data_%s_day%s = gdal.Open(beam_%s_day%s) % (hour, julian, hour, julian)
	beam_band = beam_data_%s_day%s.GetRasterBand(1) % (hour, julian)

	cols = beam_data_%s_day%s.RasterXSize % (hour, julian)
	rows = beam_data_%s_day%s.RasterYSize % (hour, julian)

	beam_transform = beam_data_%s_day%s.GetGeoTransform() % (hour, julian)

	xOrigin = beam_transform[0]
	yOrigin = beam_transform[3]
	pixelWidth = beam_transform[1]
	pixelHeight = -beam_transform[5]

	data = beam_%s_day%s_band.ReadAsArray(0, 0, cols, rows) % (hour, julian)

	points_list = [ ] #list of X,Y coordinates
		for point in coordList:
		    col = int((point[0] - xOrigin) / pixelWidth)
	    		row = int((yOrigin - point[1] ) / pixelHeight)

	    		print row,col, data[row][col]	

# Sample each row by its corresponding solar radiation raster

from osgeo import gdal,ogr
import struct

src_filename = 'home/tswetnam/Downloads/bighorns/hand_run/beam_rad_%s_day%s.tif' % (day,hour)
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
