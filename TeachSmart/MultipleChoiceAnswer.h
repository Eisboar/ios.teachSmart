//
//  MultipleChoiceAnswer.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 08/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultipleChoiceAnswer : NSObject

@property (atomic, readonly) int position;
@property (atomic, strong, readonly) NSString* answerText;

-(id) initWithPosition:(int)position answerText:(NSString*)answerText;

@end
