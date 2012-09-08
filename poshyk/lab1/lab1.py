#!/usr/bin/python

file_dir = 'files';
file_names = ['virus', ''];
ext_splitter = '.';
path_splitter = "\\";
file_ext = 'txt';

def getFilePath (file_name) :
	return file_dir+path_splitter+file_name+ext_splitter+file_ext;

print getFilePath(file_names[0])
print 'thanks'
