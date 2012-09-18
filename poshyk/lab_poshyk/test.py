#!/usr/bin/python
import os;
import json;

#author: maksym hontar
#running notes: run from folder in terminal: ./lab1.py

def emptyList(n) :
	list = [];
	for i in xrange(0,n):
		list.append(0);
	return list;

# array = { 'word' : emptyList(10)};
# array['word'][1] = 1;
# print array;

# print [1,2,3].index(2);

# list = {"c": [1,2,3], "b": 0, "a": ["12easd","asd"]};
# json_dump = json.dumps(list, sort_keys=True);
# print json_dump;

# print len('123');

# res = [];
# arr1 = [1,0,1];
# arr2 = [0,1,1];
# for i in xrange(0,len(arr1)):
# 	res.append(arr1[i] & arr2[i]);

# print res;