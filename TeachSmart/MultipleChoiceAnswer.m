//
//  MultipleChoiceAnswer.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 08/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "MultipleChoiceAnswer.h"

@implementation MultipleChoiceAnswer


-(id) initWithPosition:(int)position answerText:(NSString*)answerText{
    self = [super init];
    if (self){
        _position = position;
        _answerText = answerText;
    }
    return self;
}

@end
