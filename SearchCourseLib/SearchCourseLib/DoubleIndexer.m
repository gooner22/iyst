//
//  DoubleIndexer.m
//  SearchCourseLib
//
//  Created by Maksym Hontar on 30.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import "DoubleIndexer.h"
#import "NSMutableString+StringSymbolsStripper.h"
#import "NSArray+Tag.h"
#import "Utils.h"

@interface DoubleIndexer(){
    NSMutableDictionary* _doubleIndex;
}
@end

#pragma mark NSCoding Protocol

@implementation DoubleIndexer

- (id) init{
    if(!(self = [super init])){
        return nil;
    }
    
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[Utils getDoubleIndexerPath]] options:NSJSONReadingMutableContainers error:nil];
    if(dictionary){
        _doubleIndex = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    }
    if(!_doubleIndex){
        _doubleIndex = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (NSString*) getKeyFromWord:(NSString*)word andWord:(NSString*)anotherWord{
    return [NSString stringWithFormat:@"%@ %@", word, anotherWord];
}

- (NSMutableArray*) getDoubleIndexArrayForKey:(NSString*)key{
    if(![_doubleIndex valueForKey:key]){
        [_doubleIndex setValue:[NSMutableArray array] forKey:key];
    }
    return [_doubleIndex valueForKey:key];
}

- (void) updateDoubleIndexArrayForKey:(NSString*)key withDocId:(NSNumber*)docId{
    NSMutableArray* mutableArray = [self getDoubleIndexArrayForKey:key];
    if(![mutableArray containsObject:docId]){
        [mutableArray addObject:docId];
    }
}

- (void) indexWithArray:(NSArray*)array{
    NSString* previousWord = nil;
    for (NSString *word in array) {
        if(![previousWord isEqualToString:@""] && ![word isEqualToString:@""] && word.length < 36 && previousWord.length < 36){
            NSString* key = [self getKeyFromWord:previousWord andWord:word];
            [self updateDoubleIndexArrayForKey:key withDocId:array.tag];
        }
        previousWord = word;
    }
}

- (void) indexLibraryWithDoubleIndex{
    int docId = 0;
    for (NSString* path in [Utils getFilesPaths]) {
        [self indexLibraryWithDoubleIndexText:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] docId:@(++docId)];
    }
}

- (void) indexLibraryWithDoubleIndexText:(NSString*)textInput docId:(NSNumber*)docId{
    NSMutableString *text = [NSMutableString stringWithString:textInput];
    [text stripStuffPrepareToIndexation];
    NSArray* document = [text componentsSeparatedByString:spaceString];
    document.tag = docId;
    [self indexWithArray:document];
}

- (void) indexLibraryWithDoubleIndexFakeText:(NSString*)textInput{
    [self indexLibraryWithDoubleIndexText:textInput docId:@(1)];
}

- (BOOL) performSearchWithQuery:(NSString*)query{
    NSMutableString *text = [NSMutableString stringWithString:query];
    [text stripStuffPrepareToIndexation];
    NSArray* words = [text componentsSeparatedByString:spaceString];
    
    NSString* previousWord = nil;
    for (NSString *word in words) {
        if(previousWord){
            NSString* key = [self getKeyFromWord:previousWord andWord:word];
            NSArray* docIds = [self getDoubleIndexArrayForKey:key];
            if(docIds.count>0){
                return YES;
            }
        }
        previousWord = word;
    }
    return NO;
}

- (BOOL)serialize{
    NSData* data = [NSJSONSerialization dataWithJSONObject:_doubleIndex options:NSJSONWritingPrettyPrinted error:nil];
    return [data writeToFile:[Utils getDoubleIndexerPath] atomically:NO];
//    return [_doubleIndex writeToFile:[Utils getDoubleIndexerPath] atomically:NO];
}
@end
