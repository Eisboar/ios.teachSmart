//
//  QuestionViewModelController.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 07/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "QuestionViewModelController.h"

@interface QuestionViewModelController()
@property (nonatomic, strong) NSArray *dummyData;
@end


@implementation QuestionViewModelController

@synthesize dummyData = _dummyData;



-(id) initWithQuestionSheet:(QuestionSheet*)questionSheet{
    self = [super init];
    
    if (self){
        _questionSheet = questionSheet;
    }
    
    return self;
}

- (QuestionViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    NSLog(@"try to retrive conroller %i",index);
    
    if (index>=_questionSheet.questions.count)
        return nil;
    
    //check if data is there to be displayed or if index
    //is out of range
//    if ([self.dummyData count] == 0 || index >= [self.dummyData count]) {
//        return nil;
//    }
//    
    QuestionViewController *questionViewController = [[QuestionViewController alloc] initWithQuestion:_questionSheet.questions[index] questionCount:_questionSheet.questions.count];
    //[storyboard instantiateViewControllerWithIdentifier:@"QuestionViewController"];
    //questionViewController.someText = self.dummyData[index];
    return questionViewController;
}

- (NSUInteger)indexOfViewController:(QuestionViewController *)viewController{
    return viewController.question.position-1;
}



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    NSLog(@"fired");
    NSUInteger index = [self indexOfViewController:(QuestionViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSLog(@"fired2");
    NSUInteger index = [self indexOfViewController:(QuestionViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.dummyData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end