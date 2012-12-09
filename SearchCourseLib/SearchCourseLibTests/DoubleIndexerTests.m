
//  DoubleIndexerTests.m
//  SearchCourseLib
//
//  Created by Maksym Hontar on 30.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import "DoubleIndexerTests.h"

@implementation DoubleIndexerTests

- (void)setUp
{
    [super setUp];
    
    di = [[DoubleIndexer alloc] init];
//    [di indexLibraryWithDoubleIndexFakeText:@"Paolo Alto Standtford University vasia petia iOS Development Courses"];
//    [di indexLibraryWithDoubleIndex];
}

- (void)tearDown
{
    STAssertTrue([di serialize], @"Can not serialize double indexer");
    
    [super tearDown];
}

- (void)testIndexing
{

    STAssertTrue([di performSearchWithQuery:@"STANDTFORD UNIVERSITY"], @"ERROR");
    STAssertTrue([di performSearchWithQuery:@"STANDTFORD Paolo Alto"], @"ERROR");    
    STAssertFalse([di performSearchWithQuery:@"STANDTFORD LOL"], @"ERROR");
    
    STAssertTrue([di performSearchWithQuery:@"to be"], @"ERROR");
    STAssertTrue([di performSearchWithQuery:@"I am"], @"ERROR");

    STAssertTrue([di performSearchWithQuery:@"he is man of my dream"], @"ERROR");
    STAssertTrue([di performSearchWithQuery:@"beautiful woman and man"], @"ERROR");

}

@end
