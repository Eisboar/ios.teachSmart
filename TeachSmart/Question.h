//
//  Question.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 02/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (atomic, readonly) int position;
@property (atomic, readonly, strong) NSString* questionText;

- (id)initWithPosition:(int)position questionText:(NSString*)questionText;

@end
