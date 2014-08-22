//
//  MultipleChoiceQuestion.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 08/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "Question.h"

@interface MultipleChoiceQuestion : Question

@property (atomic, strong, readonly) NSArray* answers;

- (id)initWithPosition:(int)position questionText:(NSString*)questionText answers:(NSArray*)answers;

@end
