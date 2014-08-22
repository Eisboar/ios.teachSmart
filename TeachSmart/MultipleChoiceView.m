//
//  MultipleChoiceView.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 08/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "MultipleChoiceView.h"
#import "constants.h"
#import "MultipleChoiceAnswer.h"

@interface MultipleChoiceView(){
    float _y_current;
    NSMutableArray* checkBoxes;
    NSMutableArray* checkBoxStates; //array of bools
}


@end

@implementation MultipleChoiceView

- (id)initWithFrame:(CGRect)frame answers:(NSArray*)answers y_current:(float)y_current
{
    self = [super initWithFrame:frame];
    if (self) {
        _y_current = y_current;
        //[self initCheckBox];
        checkBoxes = [[NSMutableArray alloc] init];
        checkBoxStates = [[NSMutableArray alloc] init];
        for (MultipleChoiceAnswer *multipleChoiceAnswer in answers){
            UIButton *checkbox = [self createCheckbox];
            [checkBoxes addObject:checkbox];
            [self initAnswerLabelwithAnswerText:multipleChoiceAnswer.answerText];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIButton*)createCheckbox{
    UIButton *checkbox;
    checkbox = [[UIButton alloc] init];
    [checkBoxStates addObject:@"NO"];
    [checkbox setTitle: @"\u2B1C" forState:UIControlStateNormal];
    //[checkbox setTitle: @"\u2611" forState:UIControlStateSelected];
    [checkbox addTarget:self
                 action:@selector(checkboxClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    CGRect checkboxRect = [checkbox.titleLabel.text
                           boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT)
                           options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:checkbox.titleLabel.font}
                           context:nil];
    [checkbox setBounds:checkboxRect];
    
    return checkbox;
}

- (void)initCheckBox{
    UIButton *checkbox;
    //BOOL checkBoxSelected;
    checkbox = [[UIButton alloc] initWithFrame:CGRectMake(100,100,100,100)];
    // 20x20 is the size of the checckbox that you want
    // create 2 images sizes 20x20 , one empty square and
    // another of the same square with the checkmark in it
// Create 2 UIImages with these new images, then:
                
    [checkbox setTitle:@"\u2705" forState:UIControlStateNormal];
    [self addSubview:checkbox];
}

- (void)checkboxClicked:(UIButton*)checkBox{
    int ID = [checkBoxes indexOfObject:checkBox];
    NSString *checked;
   // NSInteger value = [number integerValue];
    NSLog(@"%@",checkBoxStates[ID]);
    if ([checkBoxStates[ID] isEqualToString:@"YES"]){
        [checkBox setTitle: @"\u2B1C" forState:UIControlStateNormal];
        checked = @"NO";
    } else{
        for (int i = 0; i < checkBoxes.count; i++)
             [self uncheckBoxWithID:i];
        [checkBox setTitle: @"\u2611" forState:UIControlStateNormal];
        checked = @"YES";
    }
    checkBoxStates[ID]=checked;
    
}

-(void) uncheckBoxWithID:(int)ID{
    UIButton* checkBox = checkBoxes[ID];
    [checkBox setTitle: @"\u2B1C" forState:UIControlStateNormal];
    checkBoxStates[ID]=@"NO";

}

- (void)initAnswerLabelwithAnswerText:(NSString*)answerText{
    UIButton *checkbox = [checkBoxes lastObject];

    //create Label
    UILabel* answerTextLabel= [[UILabel alloc] initWithFrame:self.frame];
    //set text and style
    [answerTextLabel setText:answerText];
    answerTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    answerTextLabel.textAlignment = NSTextAlignmentLeft;
    
    //calculate text bounds
    CGSize maxSize = CGSizeMake(self.frame.size.width-(3*x_view_padding)-checkbox.frame.size.width, MAXFLOAT);
    CGRect labelRect = [answerText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:answerTextLabel.font} context:nil];
    int numberOfLines =  labelRect.size.height / answerTextLabel.font.lineHeight;
    
    //set height and position
    [answerTextLabel setNumberOfLines:numberOfLines];
    labelRect.size.width = maxSize.width;
    [answerTextLabel setBounds:labelRect];
    answerTextLabel.frame = CGRectMake(2*x_view_padding+checkbox.frame.size.width, y_view_padding+_y_current, labelRect.size.width, labelRect.size.height);
    
    //add label
    [self addSubview:answerTextLabel];
   
    checkbox.frame = CGRectMake(x_view_padding,_y_current+y_view_padding+labelRect.size.height/2-checkbox.frame.size.height/2,checkbox.frame.size.width,checkbox.frame.size.height);
    [self addSubview:checkbox];
     _y_current +=y_view_padding + answerTextLabel.frame.size.height;
}

@end
