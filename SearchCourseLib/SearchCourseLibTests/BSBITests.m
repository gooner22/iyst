//
//  BSBITests.m
//  SearchCourseLib
//
//  Created by Maksym Hontar on 07.11.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import "BSBITests.h"

@implementation BSBITests
- (void)setUp
{
    [super setUp];
    
    _bsbi = [[BSBI alloc] init];
}

- (void)tearDown
{
    STAssertTrue([_bsbi serialize], @"Can not serialize bsbi");
    
    [super tearDown];
}

- (void)testIndex{
    [_bsbi indexLibraryWithBSBIIndex];
}
@end
