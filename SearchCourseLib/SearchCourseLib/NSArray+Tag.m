//
//  NSArray+Tag.m
//  SearchCourseLib
//
//  Created by Maksym Hontar on 30.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import "NSArray+Tag.h"
#import <objc/runtime.h>

@implementation NSArray (Tag)
- (void) setTag:(NSNumber *)tag{
    objc_setAssociatedObject(self, @"TAG", tag, OBJC_ASSOCIATION_ASSIGN);
}

- (NSNumber*) tag{
    return objc_getAssociatedObject(self, @"TAG");
}
@end
