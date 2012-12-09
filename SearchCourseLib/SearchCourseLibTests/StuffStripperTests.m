//
//  StuffStripperTests.m
//  SearchCourseLib
//
//  Created by Maksym Hontar on 30.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import "StuffStripperTests.h"
#import "NSMutableString+StringSymbolsStripper.h"

@implementation StuffStripperTests

- (void) testStuffStripping{
    NSMutableString *income = [NSMutableString stringWithString:@"!@l#$o%^l&*()_+o-l"];
    NSString *preferable = @"lolol";
    [income stripStuffPrepareToIndexation];
    STAssertTrue([income isEqualToString:preferable], @"strings aren't equal %@ to %@",income, preferable);
}

- (void) testStuffStrippingAnother{
    NSMutableString *income = [NSMutableString stringWithString:@"lol\t\t123\n\nasd"];
    NSString *preferable = @"lol123  asd";
    [income stripStuffPrepareToIndexation];
    STAssertTrue([income isEqualToString:preferable], @"strings aren't equal %@ to %@",income, preferable);
}


- (void) testStuffStrippingNewLines{
    NSMutableString *income = [NSMutableString stringWithString:@"\nThat this was the usual procedure was so well known to Hook that in\ndisregarding it he cannot be excused on the plea of ignorance."];
    NSString *preferable = @" that this was the usual procedure was so well known to hook that in disregarding it he cannot be excused on the plea of ignorance";
    [income stripStuffPrepareToIndexation];
    STAssertTrue([income isEqualToString:preferable], @"strings aren't equal %@ to %@",income, preferable);
}

- (void) testStuffStrippingNewComas{
    NSMutableString *income = [NSMutableString stringWithString:@"...species, and with almost supernatural..."];
    NSString *preferable = @"species and with almost supernatural";
    [income stripStuffPrepareToIndexation];
    STAssertTrue([income isEqualToString:preferable], @"strings aren't equal %@ to %@",income, preferable);
}

@end