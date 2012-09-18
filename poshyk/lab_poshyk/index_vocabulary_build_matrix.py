#!/usr/bin/python
import os;
import helper;

#author: maksym hontar
#running notes: run from folder in terminal: ./index_vocabulary_build_matrix.py

if len(helper.file_paths):
	#open f

	voc_file = open(helper.getFilePath(helper.voc_file_name), 'r');
	vocabulary = voc_file.read().split(helper.new_line_char);
	print 'vocabulary count before reading: ' + str(len(vocabulary));
	voc_file.close();

	#incident_matrix_file = open(helper.getFilePath(helper.incident_matrix_file_name), 'r');
	#incident_matrix_file.close();
	incident_matrix = {};
	incident_matrix_width = len(helper.file_paths);

	for a_file_path in helper.file_paths:
		file_id = helper.file_paths.index(a_file_path);
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

					# check vocabulary
					if not word in vocabulary:
						vocabulary.append(word);

					# fill out the matrix
					if not word in incident_matrix :
						incident_matrix[word] = helper.emptyList(incident_matrix_width);
					incident_matrix[word][file_id] = 1;
		else:
			print "can't open file " + a_file_path + 'for reading';

	voc_file = open(helper.getFilePath(helper.voc_file_name), 'w+');
	helper.writeArrayToFile(vocabulary, voc_file);
	print 'vocabulary count: ' + str(len(vocabulary)) + '. file size: '+ helper.fileSize(a_file_path);
	voc_file.close();

	incident_matrix_file = open(helper.getFilePath(helper.incident_matrix_file_name), 'w+');
	helper.writeIncidentMatrixToFile(incident_matrix, incident_matrix_file);
	incident_matrix_file.close();

else:
	print "there is no files to be processed";


print 'thanks';
