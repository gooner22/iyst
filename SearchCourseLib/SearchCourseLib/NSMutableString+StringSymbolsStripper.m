//
//  NSMutableString+StringSymbolsStripper.m
//  SearchCourseLib
//
//  Created by Maksym Hontar on 30.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import "NSMutableString+StringSymbolsStripper.h"

@implementation NSMutableString (StringSymbolsStripper)
- (void) stripStuffPrepareToIndexation{
    //replacing new lines
    [self setString:[self stringByReplacingOccurrencesOfString:@"\n" withString:@" "]];
    //removing stuff
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"@!#$%^&*()-_+=¡™£¢∞§•ªªº–≠\t\a\b\v\f\r`~[]{}\"\'\\|/?><,.±«\n;:"];
    [self setString:[[[self componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""] lowercaseString]];
    
}
@end