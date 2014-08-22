//
//  Question.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 02/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "Question.h"

@implementation Question

- (id)initWithPosition:(int)position questionText:(NSString*)questionText{
    self = [super init];
    if (self){
        _position = position;
        _questionText = questionText;
    }
    return self;
}

@end
