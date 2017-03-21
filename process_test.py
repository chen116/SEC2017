# for SF

# import sys
# import os

# flist=[]
# lon_diff = 0.0135;
# lat_diff= 0.0112;

# for content in os.listdir("./big_data/"): # "." means current directory
#     flist.append(content)
# ct=1;
# min_time = 0#1211018404
# for each_file in flist:
# 	file = open("./big_data/"+each_file, "r") 
# 	wf = open("test_data/"+each_file,"w");
# 	lines = file.readlines() 
# 	cnt = 0
# 	for each_line in lines:
# 		# if min_time > long(each_line.split()[3]):
# 		# 	min_time = long(each_line.split()[3])
# 		#if float(each_line.split()[0]) >= 37.755 and float(each_line.split()[0]) <= 37.800 and float(each_line.split()[1]) >= -122.465 and float(each_line.split()[1]) <= -122.408:
# 		if float(each_line.split()[0]) >= 37.775-lat_diff and float(each_line.split()[0]) <= 37.785+lat_diff and float(each_line.split()[1]) >= -122.443-lon_diff and float(each_line.split()[1]) <= -122.430+lon_diff:
# 		#big area # if float(each_line.split()[0]) >= 37.745 and float(each_line.split()[0]) <= 37.7785 and float(each_line.split()[1]) >= -122.442 and float(each_line.split()[1]) <= -122.436:
# 			wf.write(each_line.split()[0]+","+each_line.split()[1]+","+str(int(each_line.split()[3])-min_time)+"\n");
# 	file.close();
# 	wf.close();


# min_time = 9999999999
# max_time = -1

# file = open("./test_data/"+flist[0], "r") 
# lines = file.readlines() 
# for each_line in lines:
# 	if min_time > int(each_line.split(',')[2]):
# 		min_time = int(each_line.split(',')[2])
# 	if max_time < int(each_line.split(',')[2]):
# 		max_time = int(each_line.split(',')[2])

# print "min_time="+str(min_time)+";"
# print "max_time="+str(max_time)+";"


# print str(37.775-lat_diff)+","+str(-122.430+lon_diff)
# print str(37.785+lat_diff)+","+str(-122.430+lon_diff)
# print str(37.775-lat_diff)+","+str(-122.443-lon_diff )
# print str(37.785+lat_diff)+","+str(-122.443-lon_diff )

# for rome


import sys
import os

flist=[]
lon_diff = 0;
lat_diff= 0;
# % 41.915220, 12.48
# % 41.883314, 12.48
# % 41.915220, 12.522653
# % 41.883314,12.522653
for content in os.listdir("./roma_big/"): # "." means current directory
    flist.append(content)
ct=1;
min_time = 0#1211018404
for each_file in flist:
	file = open("./roma_big/"+each_file, "r") 
	wf = open("test_roma_data/"+each_file,"w");
	lines = file.readlines() 
	cnt = 0
	for each_line in lines:
		# if min_time > long(each_line.split()[3]):
		# 	min_time = long(each_line.split()[3])
		#if float(each_line.split()[0]) >= 37.755 and float(each_line.split()[0]) <= 37.800 and float(each_line.split()[1]) >= -122.465 and float(each_line.split()[1]) <= -122.408:
		if float(each_line.split(",")[0]) >= 41.883314-lat_diff and float(each_line.split(",")[0]) <= 41.915220+lat_diff and float(each_line.split(",")[1]) >= 12.48-lon_diff and float(each_line.split(",")[1]) <= 12.522653+lon_diff:
		#big area # if float(each_line.split()[0]) >= 37.745 and float(each_line.split()[0]) <= 37.7785 and float(each_line.split()[1]) >= -122.442 and float(each_line.split()[1]) <= -122.436:
			wf.write(each_line);
	file.close();
	wf.close();


min_time = 9999999999
max_time = -1

file = open("./test_roma_data/"+flist[0], "r") 
lines = file.readlines() 
for each_line in lines:
	if min_time > int(each_line.split(',')[2]):
		min_time = int(each_line.split(',')[2])
	if max_time < int(each_line.split(',')[2]):
		max_time = int(each_line.split(',')[2])

print "min_time="+str(min_time)+";"
print "max_time="+str(max_time)+";"


print str(37.775-lat_diff)+","+str(-122.430+lon_diff)
print str(37.785+lat_diff)+","+str(-122.430+lon_diff)
print str(37.775-lat_diff)+","+str(-122.443-lon_diff )
print str(37.785+lat_diff)+","+str(-122.443-lon_diff )



# wf = open("test_data.txt","w");
# for each_file in flist:
# 	file = open("./test_data/"+each_file, "r") 
# 	lines = file.readlines() 
# 	for each_line in lines:
# 		wf.write(each_line+"\n");
# print min_time
