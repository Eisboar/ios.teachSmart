//
//  QuestionSheet.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 02/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "QuestionSheet.h"

@implementation QuestionSheet

//creates full a questionsheet with questions
- (id)initWithID:(int)ID name:(NSString*)name timestamp:(NSString*)timestamp questions:(NSMutableArray*)questions{
    
    self = [super init];
    if (self){
        _ID = ID;
        _timestamp = timestamp;
        _name = name;
        _questions = questions;
    }
    return self;
}

//is more like an information overview about the sheet, without the questions itselfs
//(maybe should be an own object)
- (id)initWithID:(int)ID name:(NSString*)name timestamp:(NSString*)timestamp{
    self = [super init];
    if (self){
        _ID = ID;
        _timestamp = timestamp;
        _name = name;
    }
    return self;
}

@end
