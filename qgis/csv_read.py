import csv, os

# Set input file directory
input_Dir = '/vol_d/bighorns/hand_run/'

gps_locations = csv.reader(open("/vol_c/bighorns/CPNWR_DBS_Locs.csv"), delimiter=",")
header = gps_locations.next()
print(header)

# Create output sampled .csv file structure

caseIndex = header.index('case')
latIndex = header.index('lat')
longIndex = header.index('long')
hourIndex = header.index('hour')
julianIndex = header.index("julian")

coordList = []

for row in gps_locations:
	case = row[caseIndex]
	lat = row[latIndex]
	lon = row[longIndex]
	hour = row[hourIndex]
	julian = row[julianIndex]
	coordList.append([case,lat,lon,hour,julian])

# Create output file
with open("/vol_c/bighorns/output.csv","wb") as f:
    field_names = ["case", "lat", "lon", "hour", "julian", "beam", "glob"]
    out = csv.DictWriter(f,fieldnames=field_names, extrasaction='ignore', delimiter = ',')
    out.writeheader()
    out = csv.writer(f)
    out.writerows(coordList)

coords = csv.reader(open("/vol_c/bighorns/output.csv"), delimiter=",")
coords_new = csv.writer(open("/vol_c/bighorns/new_output.csv", 'w'))
header = coords.next()	
coord_data = list(coords)

# Prepare for raster importing
from osgeo import gdal
format = "GTiff"
driver = gdal.GetDriverByName( format )

for row in coord_data:
    case, lat, lon, hour, julian = row
    if int(hour) <= 5: 
        print "Observation is %s:00 hours before sunrise, writing null value for radiation on day %s" % (hour, julian)
        coords_new.writerow([case, lat, lon, hour, julian, '0', '0'])
    elif int(hour) >= 21: 
        print "Observation is %s:00 hours at night, writing null value for radiation on day %s" % (hour, julian)
        coords_new.writerow([case, lat, lon, hour, julian, '0', '0'])
    else: 
        print "Observation is at %s:00 hours, sampling for global and beam irradiance on day %s" % (hour, julian)
        # sample global radiation
        glob_dst_ds = os.path.join(input_Dir,'glob_rad_%s_day%s.tif') % (hour, julian)
        glob_data = gdal.Open(glob_dst_ds) 
        glob_band = glob_data.GetRasterBand(1)
        cols = glob_data.RasterXSize
        rows = glob_data.RasterYSize
        glob_transform = glob_data.GetGeoTransform()
        xOrigin = glob_transform[0]
        yOrigin = glob_transform[3]
        pixelWidth = glob_transform[1]
        pixelHeight = -glob_transform[5]
        data_glob = glob_band.ReadAsArray(0, 0, cols, rows)
        # sample direct beam irradiance 
        beam_dst_ds = os.path.join(input_Dir,'beam_rad_%s_day%s.tif') % (hour, julian)
        beam_data = gdal.Open(beam_dst_ds) 
        beam_band = beam_data.GetRasterBand(1)
        cols = beam_data.RasterXSize
        rows = beam_data.RasterYSize
        beam_transform = beam_data.GetGeoTransform()
        xOrigin = beam_transform[0]
        yOrigin = beam_transform[3]
        pixelWidth = beam_transform[1]
        pixelHeight = -beam_transform[5]
        data_beam = beam_band.ReadAsArray(0, 0, cols, rows) 
        for ob in coord_data:
            obs1 = float(ob[1])
            row = int((yOrigin - obs1) / pixelHeight)
            obs2 = float(ob[2])
            col = int((obs2 - xOrigin) / pixelWidth)
            coords_new.writerow([case, lat, lon, hour, julian, data_glob[row][col], data_beam[row][col]])
        	# Load Layers into QGIS
		# glob_dst_dsLayer = QgsRasterLayer(glob_dst_ds, 'glob_rad_%s_day%s' % (hour, julian))
        	# QgsMapLayerRegistry.instance().addMapLayer(glob_dst_dsLayer)
        	# if not glob_dst_dsLayer.isValid(): print "glob_rad_%s_day%s.tif layer not found" % (hour, julian)
