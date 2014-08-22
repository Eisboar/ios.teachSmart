//
//  RatingView.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 12/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "RatingView.h"
#import "constants.h"

@interface RatingView(){
    NSMutableArray *stars;
    float _y_current;
}

@end


@implementation RatingView

- (id)initWithFrame:(CGRect)frame y_current:(float)y_current
{
    self = [super initWithFrame:frame];
    if (self) {
        _rating = 0;
        _y_current = y_current;
        stars = [[NSMutableArray alloc] init];
        [self initStars];
        // Initialization code
    }
    return self;
}

- (void)initStars{
    for (int i= 0; i<star_count; i++){
        [self initStarWIthID:i];
    }
}

- (void)initStarWIthID:(int)ID{
    UIButton *star;
    star = [[UIButton alloc] init];
    
    UIImage *buttonBackground = [UIImage imageNamed:@"star_unselected.png"];
    [star setImage:buttonBackground forState:UIControlStateNormal];
    
    
    //calc pos
    float starWidth = buttonBackground.size.width;
    float maxWidth = self.frame.size.width;
    float starBarWidth = starWidth*star_count;
    float x_start=(maxWidth/2)-(starBarWidth/2);
    
    star.frame = CGRectMake (x_start+ID*starWidth,_y_current+y_view_padding,starWidth,buttonBackground.size.height);
    
    //set clickMethode
    [star addTarget:self
                 action:@selector(starClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:star];
    [stars addObject:star];
}

- (void)starClicked:(UIButton*)star{
    int ID = [stars indexOfObject:star];
    UIImage *starUnselectedImage = [UIImage imageNamed:@"star_unselected.png"];
    UIImage *starSelectedImage = [UIImage imageNamed:@"star_selected.png"];
    
    for (int i =0;i<star_count; i++ ){
        if (i<=ID)
            [stars[i] setImage:starSelectedImage forState:UIControlStateNormal];
        else
            [stars[i] setImage:starUnselectedImage forState:UIControlStateNormal];
    }
    _rating = ID +1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
