//
//  Utils.m
//  SearchCourseLib
//
//  Created by Maksym Hontar on 31.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void) createIfNotExist:(NSString*)path{
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    };
}

+ (NSString*) getDoubleIndexerPath{
    NSString* path = [NSString stringWithFormat:@"%@/double.index",[NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    [Utils createIfNotExist:path];
    return path;
}

+ (NSString*) getCoordinateIndexerPath{
    NSString* path = [NSString stringWithFormat:@"%@/coordinate.index",[NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    [Utils createIfNotExist:path];
    return path;
}
+ (NSString*) getBSBIIndexPath{
    NSString* path = [NSString stringWithFormat:@"%@/BSBI.index",[NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    [Utils createIfNotExist:path];
    return path;
}
+ (NSArray*) getFilesPaths{
    return [[NSBundle bundleForClass:[self class]] pathsForResourcesOfType:@"txt" inDirectory:nil];
}

@end
