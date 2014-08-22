//
//  MultipleChoiceView.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 08/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultipleChoiceView : UIView

- (id)initWithFrame:(CGRect)frame answers:(NSArray*)answers y_current:(float)y_current;

@end
