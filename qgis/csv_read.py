import csv, os

# Set input file directory
input_Dir = '/vol_d/bighorns/hand_run/'

gps_locations = csv.reader('/vol_c/bighorns/CPNWR_DBS_Locs.csv', delimiter=",")
header = gps_locations.next()
print(header)

caseIndex = header.index('case')
latIndex = header.index('lat')
longIndex = header.index('long')
hourIndex = header.index('hour')
julianIndex = header.index("julian")

coordList = []

for row in gps_locations:
	case = row[caseIndex]
	lat = row[latIndex]
	long = row[longIndex]
	hour = row[hourIndex]
	julian = row[julianIndex]
	coordList.append([case,lat,long,hour,julian])

# Prepare to import rasters	
from osgeo import gdal
format = "GTiff"
driver = gdal.GetDriverByName( format )

for julian in gps_locations:
    for hour in gps_locations:
	# Flush previous data from memory
	beam_dst_ds = None
	# load .tif
	beam_dst_ds = os.path.join(input_Dir,'beam_rad_%s_day%s.tif') % (hour, julian)
	beam_dst_dsLayer = QgsRasterLayer(beam_dst_ds, "beam_rad") 
	if not beam_dst_dsLayer.isValid(): print "beam_%s_day%s.tif layer not found" % (hour, julian)
	QgsMapLayerRegistry.instance().addMapLayer(beam_dst_dsLayer)
				  
	# Loop through the .csv file and sample rasters by their cooresponding hour day
	beam_data = gdal.Open(beam_dst_ds) 
	beam_band = beam_data.GetRasterBand(1)

	cols = beam_data.RasterXSize
	rows = beam_data.RasterYSize

	beam_transform = beam_data.GetGeoTransform()
	xOrigin = beam_transform[0]
	yOrigin = beam_transform[3]
	pixelWidth = beam_transform[1]
	pixelHeight = -beam_transform[5]

	data = beam_band.ReadAsArray(0, 0, cols, rows) 

	points_list = [ ] #list of X,Y coordinates
		for point in coordList:
		    col = int((point[0] - xOrigin) / pixelWidth)
	    		row = int((yOrigin - point[1] ) / pixelHeight)
	
	    		print row,col, data[row][col]	
