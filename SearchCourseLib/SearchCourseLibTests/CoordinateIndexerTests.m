//
//  CoordinateIndexerTests.m
//  SearchCourseLib
//
//  Created by Maksym Hontar on 31.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import "CoordinateIndexerTests.h"

@implementation CoordinateIndexerTests

- (void)setUp
{
    [super setUp];
    
    ci = [[CoordinateIndexer alloc] init];
//    [ci indexLibraryWithCoordinateIndexFakeText:@"Paolo Alto Standtford University vasia petia iOS Development Paolo Alto Courses"];
//    [ci indexLibraryWithCoordinateIndex];
}

- (void)tearDown
{
    STAssertTrue([ci serialize], @"Can not serialize coordinate indexer");
    
    [super tearDown];
}

- (void)testIndexing
{
    
    STAssertTrue([ci performSearchWithQuery:@"STANDTFORD UNIVERSITY"], @"ERROR");
    STAssertTrue([ci performSearchWithQuery:@"STANDTFORD Paolo Alto"], @"ERROR");
//    STAssertFalse([di performSearchWithQuery:@"STANDTFORD LOL"], @"ERROR");
//
    STAssertTrue([ci performSearchWithQuery:@"to be a footballer"], @"ERROR");
    STAssertTrue([ci performSearchWithQuery:@"I am"], @"ERROR");
//
    STAssertTrue([ci performSearchWithQuery:@"he is man of my dream"], @"ERROR");
//    STAssertTrue([ci performSearchWithQuery:@"lollards spec"], @"ERROR");
//
}
@end
