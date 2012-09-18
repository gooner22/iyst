#!/usr/bin/python
import os;
import helper;

#author: maksym hontar
#running notes: run from folder in terminal: ./lab1.py

# #file dir
# file_dir = 'files';

# #file names to read from
# file_names = ['peter_pen.txt','private.txt','horsewoman.txt','princess_of_mars.txt','reublic_plato.txt','the_bible.txt','the_prince.txt','tom_sawyer.txt','william.txt','virus.txt'];

# #output file name
# voc_file_name = 'vocabulary.txt';

# #path splitter
# path_splitter = "/";

# # str work helpers
# ascii_start = 0;
# ascii_end = 127;
# space_index = 32;
# new_line_index = 10;
# space_char = chr(space_index);
# empty_char = '';
# new_line_char = chr(new_line_index);

# def getFilePath (file_name) :
# 	return file_dir + path_splitter + file_name;

# #simple array contains
# def arrayContains (array, value) :
# 	for a_value in array:
# 		if value == a_value:
# 			return 1;
# 	return 0;

# def writeArrayToFile (array,file):
# 	for item in array:
# 		if item != empty_char:
# 			 print>>file, item

# def readFileToArray (file):
# 	return file.read().split(new_line_char);

# def fileSize(filePath):
# 	statinfo = os.stat(filePath);
# 	return str(statinfo.st_size);

# #instantiate an array
# file_paths = [];

# for a_file_name in file_names:
# 	file_paths.append(getFilePath(a_file_name))

if len(helper.file_paths):
	#open f

	voc_file = open(helper.getFilePath(helper.voc_file_name), 'r');
	vocabulary = voc_file.read().split(helper.new_line_char);
	print 'vocabulary count before reading: ' + str(len(vocabulary));
	voc_file.close();

	for a_file_path in helper.file_paths:
		file = open(a_file_path, 'r');
		if file:
			#files reading block
			print "files is being read " + a_file_path + '. file size: '+ helper.fileSize(a_file_path);
			file_content = file.read();
			file.close();

			# replace all \n with spaces
			file_content = file_content.replace(helper.new_line_char,helper.space_char);

			# strip all specific symbols
			i=helper.ascii_start;
			while i <= helper.ascii_end : 
				if i == 65 or i == 97 :
					i += 26; 
				# need to replace spaces in regex
				if i != helper.space_index and i != helper.new_line_index:
					file_content = file_content.replace(chr(i),helper.empty_char);
				i+=1;

			words = file_content.split(helper.space_char);

			for word in words:
				if word != helper.empty_char and word != helper.space_char:
					#lowercase it
					word = word.lower();
					if not word in vocabulary:
						vocabulary.append(word);
		else:
			print "can't open file " + a_file_path + 'for reading';

	voc_file = open(helper.getFilePath(helper.voc_file_name), 'w+');
	helper.writeArrayToFile(vocabulary, voc_file);
	print 'vocabulary count: ' + str(len(vocabulary)) + '. file size: '+ helper.fileSize(a_file_path);
	voc_file.close();


else:
	print "there is no files to be processed";


print 'thanks';
