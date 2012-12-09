//
//  CoordinateIndexer.h
//  SearchCourseLib
//
//  Created by Maksym Hontar on 31.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//
// lol

#import <Foundation/Foundation.h>

@interface CoordinateIndexer : NSObject
- (void) indexLibraryWithCoordinateIndex;

// test only
- (void) indexLibraryWithCoordinateIndexFakeText:(NSString*)text;

- (BOOL) performSearchWithQuery:(NSString*)query;

- (BOOL)serialize;

@end
