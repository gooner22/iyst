#!/usr/bin/python
import os;
import helper;

#author: maksym hontar
#running notes: run from folder in terminal: ./index_vocabulary_build_matrix.py

incident_matrix_file = open(helper.getFilePath(helper.incident_matrix_file_name), 'r');
incident_matrix = helper.readIncidentMatrixFromFile(incident_matrix_file);
incident_matrix_file.close();

word1 = 'man';
boolExpression = 'AND';
word2 = 'stupid';

if len(incident_matrix):
	if len(word1) and len(word2) and len(boolExpression) :
		res = [];
		
		if word1 in incident_matrix and word2 in incident_matrix:
			word_list1 = incident_matrix[word1];
			word_list2 = incident_matrix[word2];

			if len(word_list1) and len(word_list2):
				for i in xrange(0,len(word_list1)):
					if (boolExpression == 'AND') :
						res.append(word_list1[i] & word_list2[i]);
					elif (boolExpression == 'OR') :
						res.append(word_list1[i] | word_list2[i]);
				books_names = [];
				for i in xrange(0,len(res)) :
					if (res[i] == 1) :
						books_names.append(helper.file_names[i]);
				print 'Query \''+word1+' '+boolExpression+' '+word2+'\' resulted. Words are in following books: ' + str(books_names).strip('[]');
			else:
				print "sorry, can not parse matrix for this query";			
		else:
				print "sorry, words is missing in indexed matrix";			
	else :
		print "sorry, can not parse expressions for boolean search";

else :
	print "sorry, can not parse incident_matrix. should reindex!";


print 'thanks';
