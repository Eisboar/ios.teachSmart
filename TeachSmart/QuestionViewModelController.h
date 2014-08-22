//
//  QuestionViewModelController.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 07/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionViewController.h"
#import "QuestionSheet.h"

@interface QuestionViewModelController : NSObject <UIPageViewControllerDataSource>

@property (strong, readonly, nonatomic) QuestionSheet * questionSheet;


- (id)initWithQuestionSheet:(QuestionSheet*)questionSheet;

- (QuestionViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(QuestionViewController *)viewController;

@end
