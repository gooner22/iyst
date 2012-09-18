#!/usr/bin/python
import os;
import json;

#author: maksym hontar
#running notes: run from folder in terminal: ./lab1.py

# run mode
DEBUG = 0;
RELEASE = not DEBUG;

#file dir
file_dir = 'files';

#file names to read from
if DEBUG == 1: file_names = ['peter_pen.txt','private.txt'];
if RELEASE == 1: file_names = ['peter_pen.txt','private.txt','horsewoman.txt','princess_of_mars.txt','reublic_plato.txt','the_bible.txt','the_prince.txt','tom_sawyer.txt','william.txt','virus.txt'];	

# vocabulary output file name
voc_file_name = 'vocabulary.txt';

#matrix file name
incident_matrix_file_name = 'incident_matrix.txt';

#path splitter
path_splitter = "/";

# str work helpers
ascii_start = 0;
ascii_end = 127;
space_index = 32;
new_line_index = 10;
space_char = chr(space_index);
empty_char = '';
new_line_char = chr(new_line_index);

def getFilePath (file_name) :
	return file_dir + path_splitter + file_name;

#simple array contains
def arrayContains (array, value) :
	for a_value in array:
		if value == a_value:
			return 1;
	return 0;

def writeArrayToFile (array,file):
	for item in array:
		if item != empty_char:
			 print>>file, item

def readFileToArray (file):
	return file.read().split(new_line_char);

# incident_matrix - { key : [0,1,2..n], key2 : [3,5...n]}
def writeIncidentMatrixToFile (incident_matrix,file):
	print>>file, json.dumps(incident_matrix, sort_keys=True);

def readIncidentMatrixFromFile (file):
	return json.loads(file.read());

def fileSize(filePath):
	statinfo = os.stat(filePath);
	return str(statinfo.st_size);

def emptyList(n) :
	list = [];
	for i in xrange(0,n):
		list.append(0);
	return list;


#instantiate an array
file_paths = [];

for a_file_name in file_names:
	file_paths.append(getFilePath(a_file_name))