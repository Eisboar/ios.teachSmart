//
//  MultipleChoiceQuestion.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 08/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "MultipleChoiceQuestion.h"

@implementation MultipleChoiceQuestion

- (id)initWithPosition:(int)position questionText:(NSString*)questionText answers:(NSArray*)answers{
    self = [super initWithPosition:position questionText:questionText];
    if (self){
        _answers=answers;
    }
    return self;
}

@end
