//
//  DoubleIndexer.h
//  SearchCourseLib
//
//  Created by Maksym Hontar on 30.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoubleIndexer : NSObject

- (void) indexLibraryWithDoubleIndex;

// test only
- (void) indexLibraryWithDoubleIndexFakeText:(NSString*)text;

- (BOOL) performSearchWithQuery:(NSString*)query;

- (BOOL) serialize;
@end
