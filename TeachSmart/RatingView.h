//
//  RatingView.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 12/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingView : UIView

 - (id)initWithFrame:(CGRect)frame y_current:(float)y_current;

@property int rating; // 1-5

@end
