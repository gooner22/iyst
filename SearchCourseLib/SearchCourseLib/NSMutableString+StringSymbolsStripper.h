//
//  NSMutableString+StringSymbolsStripper.h
//  SearchCourseLib
//
//  Created by Maksym Hontar on 30.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import <Foundation/Foundation.h>
#define spaceString @" "
@interface NSMutableString (StringSymbolsStripper)
- (void) stripStuffPrepareToIndexation;
@end
