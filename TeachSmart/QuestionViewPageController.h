//
//  QuestionViewController.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 04/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionSheet.h"

@interface QuestionViewPageController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController* pageViewController;
@property (strong, nonatomic) QuestionSheet *questionSheet;

@end
