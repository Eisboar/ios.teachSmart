//
//  QuestionViewController.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 07/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionViewController : UIViewController 

@property (strong, nonatomic) NSString *someText;
@property (strong, nonatomic) Question *question;
@property (strong, nonatomic) IBOutlet UILabel *questionTextLabel;
@property (strong, nonatomic) UILabel *headlineLabel;
@property int questionCount;

- (id)initWithQuestion:(Question*)question questionCount:(int)questionCount;

@end
