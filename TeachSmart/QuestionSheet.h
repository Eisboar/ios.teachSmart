//
//  QuestionSheet.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 02/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface QuestionSheet : NSObject

@property (nonatomic, readonly) int ID; // us 'ID', cause 'id' is taken bz objective-C
@property (nonatomic, readonly) NSString *timestamp;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSMutableArray *questions;

- (id)initWithID:(int)ID name:(NSString*)name timestamp:(NSString*)timestamp questions:(NSMutableArray*)questions;

- (id)initWithID:(int)ID name:(NSString*)name timestamp:(NSString*)timestamp;

@end
