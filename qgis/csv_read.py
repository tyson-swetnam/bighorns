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

for x in cases:
    r.out.xyz 
