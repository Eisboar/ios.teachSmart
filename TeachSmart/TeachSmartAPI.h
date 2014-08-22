//
//  TeachSmartAPI.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 29/07/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "QuestionSheet.h"

@interface TeachSmartAPI : NSObject <NetworkCallback>

@property (strong, nonatomic, readonly) NSMutableArray *currentQuestionSheets;
@property (strong, nonatomic, readonly) QuestionSheet *currentQuestionSheet;

+ (TeachSmartAPI*)sharedInstance;
- (void) getSheets;
-(void) getSheet:(int)ID;

@end
