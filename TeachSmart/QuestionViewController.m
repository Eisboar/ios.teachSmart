//
//  QuestionViewController.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 07/08/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "QuestionViewController.h"
#import "MultipleChoiceView.h"
#import "RatingView.h"
#import "constants.h"
#import "MultipleChoiceQuestion.h"
#import "RatingQuestion.h"

@interface QuestionViewController(){
    float y_current;
}


@end

@implementation QuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (id)initWithQuestion:(Question*)question questionCount:(int)questionCount{
    self = [super init];
    if (self){
        if([question isMemberOfClass:[MultipleChoiceQuestion class]]) {
            NSLog(@"is multi");
        }
        if([question isMemberOfClass:[RatingQuestion class]]) {
             NSLog(@"is rating");
        }
        _question = question;
        _questionCount = questionCount;
        y_current = y_navbar_height;
        [self initHeadlineLabel];
        [self initQuestionTextLabel];
        if([question isMemberOfClass:[MultipleChoiceQuestion class]]) {
            MultipleChoiceQuestion* multipleChoiceQuestion = question;
            
            MultipleChoiceView *multipleChoiceView = [[MultipleChoiceView alloc] initWithFrame:self.view.frame answers:multipleChoiceQuestion.answers y_current:y_current];
            [self.view addSubview:multipleChoiceView];
        }
        if([question isMemberOfClass:[RatingQuestion class]]) {
            RatingQuestion* ratingQuestion = question;
            RatingView *ratingView =[[RatingView alloc] initWithFrame:self.view.frame y_current:y_current];
            [self.view addSubview:ratingView];
        }

        
    }
    return self;
}

-(void) initHeadlineLabel{
    //create Label
    _headlineLabel = [[UILabel alloc] initWithFrame:self.view.frame];
    
    //set text and style
    [_headlineLabel setText:[NSString stringWithFormat:@"Frage %i/%i", _question.position,_questionCount]];
    _headlineLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    _headlineLabel.textAlignment = NSTextAlignmentCenter;
    
    //set position
    _headlineLabel.frame = CGRectMake(x_view_padding, y_current+y_view_padding, self.view.frame.size.width-(2*x_view_padding), _headlineLabel.font.leading);
   // NSLog(@"leading: %f",_headlineLabel.font.leading);
    
    //add label
    [self.view addSubview: _headlineLabel];
    y_current +=y_view_padding +_headlineLabel.frame.size.height;

    
}

- (void) initQuestionTextLabel{
    //create Label
    _questionTextLabel = [[UILabel alloc] initWithFrame:self.view.frame];
    //set text and style
    [_questionTextLabel setText:_question.questionText];
    _questionTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _questionTextLabel.textAlignment = NSTextAlignmentLeft;
    
    //calculate text bounds
    CGSize maxSize = CGSizeMake(self.view.frame.size.width-(2*x_view_padding), MAXFLOAT);
    CGRect labelRect = [_question.questionText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_questionTextLabel.font} context:nil];
    int numberOfLines =  labelRect.size.height / _questionTextLabel.font.lineHeight;
    
    //set height and position
    [_questionTextLabel setNumberOfLines:numberOfLines];
    labelRect.size.width = maxSize.width;
    [_questionTextLabel setBounds:labelRect];
    _questionTextLabel.frame = CGRectMake(x_view_padding, y_view_padding+y_current, labelRect.size.width, labelRect.size.height);
    
    //add label
    [self.view addSubview:_questionTextLabel];
    y_current +=y_view_padding + _questionTextLabel.frame.size.height;
}


- (void) createAnswerLabel{
//    UILabel* answerLabel = [[UILabel alloc] initWithFrame:self.view.frame];
//    
//    //set text and style
//    [answerLabel setText:];
//    _questionTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//    _questionTextLabel.textAlignment = NSTextAlignmentLeft;

}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    MultipleChoiceView *multipleChoiceView = [[MultipleChoiceView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:multipleChoiceView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //[self.view addSubview:_questionTextLabel];
    
   // NSLog(@"size %@", NSStringFromCGSize(labelRect.size));
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
