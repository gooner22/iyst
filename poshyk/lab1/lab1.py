#!/usr/bin/python
import os;

#author: maksym hontar
#running notes: run from folder in terminal: ./lab1.py

#file dir
file_dir = 'files';

#file names to read from
file_names = ['peter_pen','private','horsewoman','princess_of_mars','reublic_plato','the_bible','the_prince','tom_sawyer','william','virus'];

#output file name
voc_file_name = 'vocabulary';

#ext splitter
ext_splitter = '.';

#path splitter
path_splitter = "/";

#files extension type
file_ext = 'txt';

# str work helpers
ascii_start = 0;
ascii_end = 127;
space_index = 32;
new_line_index = 10;
space_char = chr(space_index);
empty_char = '';
new_line_char = chr(new_line_index);

def getFilePath (file_name) :
	return file_dir + path_splitter + file_name + ext_splitter + file_ext;

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

def fileSize(filePath):
	statinfo = os.stat(filePath);
	return str(statinfo.st_size);

#instantiate an array
file_paths = [];

for a_file_name in file_names:
	file_paths.append(getFilePath(a_file_name))

if len(file_paths):
	#open f

	voc_file = open(getFilePath(voc_file_name), 'r');
	vocabulary = voc_file.read().split(new_line_char);
	print 'vocabulary count before reading: ' + str(len(vocabulary));
	voc_file.close();

	for a_file_path in file_paths:
		file = open(a_file_path, 'r');
		if file:
			#files reading block
			print "files is being read " + a_file_path + '. file size: '+ fileSize(a_file_path);
			file_content = file.read();
			file.close();

			# replace all \n with spaces
			file_content = file_content.replace(new_line_char,space_char);

			# strip all specific symbols
			i=ascii_start;
			while i <= ascii_end : 
				if i == 65 or i == 97 :
					i += 26; 
				# need to replace spaces in regex
				if i != space_index and i != new_line_index:
					file_content = file_content.replace(chr(i),empty_char);
				i+=1;

			words = file_content.split(space_char);

			for word in words:
				if word != empty_char and word != space_char:
					#lowercase it
					word = word.lower();
					if not word in vocabulary:
						vocabulary.append(word);
		else:
			print "can't open file " + a_file_path + 'for reading';

	voc_file = open(getFilePath(voc_file_name), 'w+');
	writeArrayToFile(vocabulary, voc_file);
	print 'vocabulary count: ' + str(len(vocabulary)) + '. file size: '+ fileSize(a_file_path);
	voc_file.close();


else:
	print "there is no files to be processed";


print 'thanks';
