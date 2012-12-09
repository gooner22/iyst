//
//  BSBI.m
//  SearchCourseLib
//
//  Created by Maksym Hontar on 07.11.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import "BSBI.h"
#import "NSMutableString+StringSymbolsStripper.h"
#import "NSArray+Tag.h"
#import "Utils.h"

@interface BSBI(){
    NSMutableArray *_chunk;
    NSMutableArray *_index;
}
@end

#define chunkSize (NSUInteger)10 * 1024

@implementation BSBI


- (id) init{
    if(!(self = [super init])){
        return nil;
    }
    
    NSArray* array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[Utils getBSBIIndexPath]] options:NSJSONReadingMutableContainers error:nil];
    if(array){
        _index = [NSMutableArray arrayWithArray:array];
    }
    if(!_index){
        _index = [NSMutableArray array];
    }
    
    // 100Mb. 1record = 12B. 100000/12 = 

    return self;
}

//- (void) indexHugeLibrary:(NSString*)library{
//    
//    NSData* myBlob = [library dataUsingEncoding:NSUTF8StringEncoding];
//    NSUInteger length = [myBlob length];
//    NSUInteger chunkSize = 100 * 1024;
//    NSUInteger offset = 0;
//    do {
//        NSUInteger thisChunkSize = length - offset > chunkSize ? chunkSize : length - offset;
//        NSData* chunk = [NSData dataWithBytesNoCopy:(char *)[myBlob bytes] + offset
//                                             length:thisChunkSize
//                                       freeWhenDone:NO];
//        offset += thisChunkSize;
//        [self indexChunk:(NSData*)chunk];
//        
//    } while (offset < length);
//}

- (void) sortChunk:(NSMutableArray*)chunk{
    [chunk sortUsingComparator:^(id first,id second){
        return [first compare:second options:0];
    }];
}

- (void) appendChunkToIndex:(NSMutableArray*)chunk{
    [self sortChunk:chunk];
    // append here
#warning TODO
    [_index addObjectsFromArray:chunk];
}
- (NSMutableArray*) getChunk{
    if(!_chunk){
        _chunk = [[NSMutableArray alloc] initWithCapacity:chunkSize];
    }else{
        if(_chunk.count >= chunkSize){
            [self appendChunkToIndex:_chunk];
            _chunk = nil;
            return [self getChunk];
        }
    }
    return _chunk;
}

- (NSString*)getRecordWithTermId:(NSString*)termID withDocId:(NSNumber*)docID{
    return [NSString stringWithFormat:@"%@-%@",termID,docID];
}

- (void) updateIndexChunkWithKey:(NSString*)termID withDocId:(NSNumber*)docID{
    NSMutableArray* chunk = [self getChunk];
    
    NSString* record = [self getRecordWithTermId:termID withDocId:docID];
    if (![chunk containsObject:record]){
        [chunk addObject:record];
    }
}

- (void) indexWithArray:(NSArray*)array{
    for (NSString *word in array) {
        if(![word isEqualToString:@""] && word.length < 36){
            [self updateIndexChunkWithKey:word withDocId:array.tag];
        }
    }
}


- (void) indexLibraryWithBSBIIndexText:(NSString*)textInput docId:(NSNumber*)docId{
    NSMutableString *text = [NSMutableString stringWithString:textInput];
    [text stripStuffPrepareToIndexation];
    NSArray* document = [text componentsSeparatedByString:spaceString];
    document.tag = docId;
    [self indexWithArray:document];
}

- (void) indexLibraryWithBSBIIndex{
    int docId = 0;
    for (NSString* path in [Utils getFilesPaths]) {
        [self indexLibraryWithBSBIIndexText:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] docId:@(++docId)];
    }
}

// test only
- (void) indexLibraryWithBSBIIndexFakeText:(NSString*)textInput{
    [self indexLibraryWithBSBIIndexText:textInput docId:@(999)];
}

- (BOOL)serialize{
    NSData* data = [NSJSONSerialization dataWithJSONObject:_index options:NSJSONWritingPrettyPrinted error:nil];
    return [data writeToFile:[Utils getBSBIIndexPath] atomically:NO];
}

@end
