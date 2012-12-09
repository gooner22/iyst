//
//  CoordinateIndexer.m
//  SearchCourseLib
//
//  Created by Maksym Hontar on 31.10.12.
//  Copyright (c) 2012 Maksym Hontar. All rights reserved.
//

#import "CoordinateIndexer.h"
#import "Utils.h"
#import "NSMutableString+StringSymbolsStripper.h"
#import "NSArray+Tag.h"

@interface CoordinateIndexer(){
    NSMutableDictionary* _coordinateIndex;
}
@end

@implementation CoordinateIndexer

- (id) init{
    if(!(self = [super init])){
        return nil;
    }
    
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[Utils getCoordinateIndexerPath]] options:NSJSONReadingMutableContainers error:nil];
    if(dictionary){
        _coordinateIndex = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    }
    if(!_coordinateIndex){
        _coordinateIndex = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (NSMutableDictionary*) getCoordinateIndexDictionaryForKey:(NSString*)key{
    if(![_coordinateIndex valueForKey:key]){
        [_coordinateIndex setValue:[NSMutableDictionary dictionary] forKey:key];
    }
    return [_coordinateIndex valueForKey:key];
}

- (void) updateCoordinateIndexArrayForKey:(NSString*)key withDocId:(NSNumber*)docId position:(NSNumber*)position{
    NSMutableDictionary *mutableDictionary = [self getCoordinateIndexDictionaryForKey:key];
    NSString *docIdKey = [docId stringValue];
    if(![mutableDictionary valueForKey:docIdKey]){
        [mutableDictionary setObject:[NSMutableSet set] forKey:docIdKey];
    }
    NSMutableSet *set = [mutableDictionary valueForKey:docIdKey];
    if(![set containsObject:position]){
        [set addObject:position];
    }
}

- (void) indexWithArray:(NSArray*)array{
    int position = 0;
    for (NSString *word in array) {
        if(![word isEqualToString:@""] && word.length < 36){
            [self updateCoordinateIndexArrayForKey:word withDocId:array.tag position:@(position++)];
        }
    }
}

- (void) indexLibraryWithCoordinateIndexText:(NSString*)textInput docId:(NSNumber*)docId{
    NSMutableString *text = [NSMutableString stringWithString:textInput];
    [text stripStuffPrepareToIndexation];
    NSArray* document = [text componentsSeparatedByString:spaceString];
    document.tag = docId;
    [self indexWithArray:document];
}

- (void) indexLibraryWithCoordinateIndex{
    int docId = 0;
    for (NSString* path in [Utils getFilesPaths]) {
        [self indexLibraryWithCoordinateIndexText:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] docId:@(++docId)];
    }
}

// test only
- (void) indexLibraryWithCoordinateIndexFakeText:(NSString*)textInput{
   [self indexLibraryWithCoordinateIndexText:textInput docId:@(999)];
}

- (BOOL) performSearchWithQuery:(NSString*)query{
    NSMutableString *text = [NSMutableString stringWithString:query];
    [text stripStuffPrepareToIndexation];
    NSArray* words = [text componentsSeparatedByString:spaceString];
    
    NSMutableArray* coordinatesOfEachWord = [NSMutableArray array];
    for (NSString *word in words) {
        NSMutableDictionary* coordsForWord = [self getCoordinateIndexDictionaryForKey:word];
        if(coordsForWord.count>0){
            [coordinatesOfEachWord addObject:coordsForWord];
        }
    }
    
    if(coordinatesOfEachWord.count >= 1){
        return [self searchForResultsIn:coordinatesOfEachWord];
    }else{
        return YES; // all docids for 1 word
    }
#warning TODO
    return NO;
}

- (BOOL) searchForResultsIn:(NSArray*)coordinatesOfEachWord{
    for (int i=1; i<coordinatesOfEachWord.count; ++i) {
        NSMutableDictionary* coordsForFirstWord = [coordinatesOfEachWord objectAtIndex:i-1];
        NSMutableDictionary* coordsForSecondWord = [coordinatesOfEachWord objectAtIndex:i];
        for (NSString* key in coordsForFirstWord.allKeys) {
            if([coordsForSecondWord.allKeys containsObject:key]){
                // in the same document
                NSArray* positionsFirst = [coordsForFirstWord valueForKey:key];
                NSArray* positionsSecond = [coordsForSecondWord valueForKey:key];
                for (NSNumber* position in positionsFirst) {
                    if ([positionsSecond containsObject:@([position intValue]+1)]){
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}

- (void)convertFromSets{

    for (NSString* key in _coordinateIndex.allKeys) {
        NSMutableDictionary* dictionary = [_coordinateIndex valueForKey:key];
            for (NSString* key2 in dictionary.allKeys) {
                NSMutableSet* set = [dictionary valueForKey:key2];
//                [set unionSet:set];

                NSMutableArray* array = [NSMutableArray arrayWithArray:[[set allObjects] sortedArrayUsingComparator:^(id first,id second){
                    return [[first stringValue] compare:[second stringValue] options:NSNumericSearch];
                }]];

                [dictionary setValue:array forKey:key2];
            }
    }
}
- (BOOL)serialize{
    [self convertFromSets];
    NSData* data = [NSJSONSerialization dataWithJSONObject:_coordinateIndex options:NSJSONWritingPrettyPrinted error:nil];
    return [data writeToFile:[Utils getCoordinateIndexerPath] atomically:NO];
}
@end
