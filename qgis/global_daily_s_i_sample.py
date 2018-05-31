#!/bin/bash/env python

# Script should be run in QGIS 2.18

import csv, os

# Set input file directory for the s_i calculations
input_Dir = '/vol_c/s_i/'

# Load GPS coordinates
gps_locations = csv.reader(open("/vol_c/bighorns/CPNWR_DBS_Locs.csv"), delimiter=",")
header = gps_locations.next()
print(header)

# Create output sampled s_i .csv file structure

caseIndex = header.index('case')
latIndex = header.index('lat')
longIndex = header.index('long')
hourIndex = header.index('hour')
julianIndex = header.index("julian")
#s_iIndex = header.index("s_i")

coordList = []

for row in gps_locations:
	case = row[caseIndex]
	lat = row[latIndex]
	lon = row[longIndex]
	hour = row[hourIndex]
	julian = row[julianIndex]
#    s_i = row[s_iIndex]
	coordList.append([case,lat,lon,hour,julian])

# Create output file
with open("/vol_c/bighorns/s_i_output.csv","wb") as f:
    field_names = ["case", "lat", "lon", "hour", "julian"]
    out = csv.DictWriter(f,fieldnames=field_names, extrasaction='ignore', delimiter = ',')
    out.writeheader()
    out = csv.writer(f)
    out.writerows(coordList)

coords = csv.reader(open("/vol_c/bighorns/s_i_output.csv"), delimiter=",")
coords_new = csv.writer(open("/vol_c/bighorns/new_s_i_output.csv", 'w'))
header = coords.next()	
coord_data = list(coords)

# Prepare for raster importing
from osgeo import gdal
format = "GTiff"
driver = gdal.GetDriverByName( format )

for row in coord_data:
    case = row[0]
    lat = float(row[1])
    lon = float(row[2])
    hour = row[3]
    julian = row[4]
#    s_i = row[5]
    print "Observation is at %s:00 hours, sampling for s_i on day %s" % (hour, julian)
    # sample S_i
    s_i_dst_ds = os.path.join(input_Dir,'s_i_day_reproj_%s.tif') % (julian)
    s_i_data = gdal.Open(s_i_dst_ds) 
    s_i_band = s_i_data.GetRasterBand(1)
    cols = s_i_data.RasterXSize
    rows = s_i_data.RasterYSize
    s_i_transform = s_i_data.GetGeoTransform()
    xOrigin = s_i_transform[0]
    yOrigin = s_i_transform[3]
    pixelWidth = s_i_transform[1]
    pixelHeight = -s_i_transform[5]
    data_s_i = s_i_band.ReadAsArray(0, 0, cols, rows)
    row = int((yOrigin - lat) / pixelHeight)
    col = int((lon - xOrigin) / pixelWidth)
    coords_new.writerow([case, lat, lon, hour, julian, data_s_i[row][col]])
# Load Layers into QGIS
    # s_i_dst_dsLayer = QgsRasterLayer(s_i_dst_ds, 's_i_day%s' % (julian))
    # QgsMapLayerRegistry.instance().addMapLayer(s_i_dst_dsLayer)
    # if not s_i_dst_dsLayer.isValid(): print "s_i_day%s.tif layer not found" % (hour, julian)
