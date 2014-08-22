//
//  TeachSmartAPI.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 29/07/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "TeachSmartAPI.h"
#import "HttpClient.h"
#import "constants.h"
#import "Question.h"
#import "RatingQuestion.h"
#import "MultipleChoiceQuestion.h"
#import "MultipleChoiceAnswer.h"

@interface TeachSmartAPI () {
    HttpClient* httpClient;
}

@end

@implementation TeachSmartAPI

+ (TeachSmartAPI*)sharedInstance{
    
    static TeachSmartAPI* _sharedInsatnce = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInsatnce = [[TeachSmartAPI alloc] init];
    });
    
    
    return _sharedInsatnce;
    
}

- (id)init
{
    self = [super init];
    if (self){
        httpClient = [[HttpClient alloc] init];
        httpClient.receiverDelegate=self;
    }
    return self;
}

- (void)getSheets
{
    httpClient.task=(NetworkTasks)getSheets;
    [httpClient sendHTTPPost];
}

-(void) getSheet:(int)ID{
    httpClient.task=(NetworkTasks)getSheet;
   
    NSError* error;
    //build an info object and convert to json
    NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
                          [@(ID) stringValue], @"id",nil];
    
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info 
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"Received String %@",string);
    httpClient.requestJsonData = jsonData;
    [httpClient sendHTTPPost];
}

- (void)receiveNetworkCallback:(NSDictionary *)networkResponse
{
    //check if networkError occured:
    if (networkResponse[@"error"]){
        NSLog(@"networkerror occured!!");
        NSString* message = networkErrorNotification;
        [self sendNotification:message];
        return;
    }
    
    //check if there is data
    NSData* jsonResponseData= [networkResponse objectForKey:@"jsonData"];
    if ( jsonResponseData == nil){
        NSLog(@"networkerror occured!!");
        NSString* message = networkErrorNotification;
        [self sendNotification:message];
        return;
    }

    
    //parse the servers response questionsheets
    NSError* error;
    NSMutableDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonResponseData options:NSJSONReadingMutableContainers error:&error];
    
    if (error)
        NSLog(@"JSONObjectWithData error: %@", error);
    
    NetworkTasks task = [[networkResponse valueForKey:@"task"] intValue];
    NSString* message;
    switch (task) {
        case getSheet:
        {
            NSLog(@"about to create questionsheet");
            _currentQuestionSheet = [self parseQuestionSheet:jsonObject];
            message = questionSheetLoadedNotification;
            break;
        }
        case getSheets:
        {
            _currentQuestionSheets = [self parseQuestionSheets:jsonObject];
            message = questionSheetsUpdateNotification;
            break;
        }
        default:
            break; 
    }
    
    [self sendNotification:message];
    message = @"";
}


- (QuestionSheet*)parseQuestionSheet:(NSMutableDictionary*)jsonObject{

    NSDictionary *jsonQuestionSheet = jsonObject[@"questionSheet"];
    int ID = [jsonQuestionSheet[@"ID"] intValue];
    NSString *name = jsonQuestionSheet[@"name"];
    NSString *timestamp = jsonQuestionSheet[@"create_date"];
    //parse questions
    NSArray *jsonQuestions = jsonQuestionSheet[@"questions"];
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    for (NSDictionary *jsonQuestion in jsonQuestions){
        int position = [jsonQuestion[@"position"] intValue];
        NSString* questionText=jsonQuestion[@"questionText"];
        NSString* type = jsonQuestion[@"type"];
        if ([type isEqualToString:@"rating"]){
            NSLog(@"is rating");
            [questions addObject:[[RatingQuestion alloc] initWithPosition:position questionText:questionText]];
            
        } else if ([type isEqualToString:@"multiple_choice"]){
            //parse answers
            NSLog(@"is mc");
            NSArray *jsonAnswers =jsonQuestion[@"answers"];
            NSMutableArray *answers = [[NSMutableArray alloc] init];
            for (NSDictionary *jsonAnswer in jsonAnswers){
                int position = [jsonAnswer[@"position"] intValue];
                NSString* answerText = jsonAnswer[@"answerText"];
                [answers addObject:[[MultipleChoiceAnswer alloc] initWithPosition:position answerText:answerText]];
            }
            [questions addObject:[[MultipleChoiceQuestion alloc]initWithPosition:position questionText:questionText answers:answers]];
        }
    }
    return [[QuestionSheet alloc] initWithID:ID name:name timestamp:timestamp questions:questions];
}

- (NSMutableArray*)parseQuestionSheets:(NSMutableDictionary*)jsonObject{
    
    NSArray *jsonQuestionSheetArray = jsonObject[@"questionSheets"];
    NSMutableArray *questionSheets = [[NSMutableArray alloc] init];
    for (NSDictionary *jsonQuestionSheet in jsonQuestionSheetArray)
    {
        QuestionSheet *questionsheet = [[QuestionSheet alloc ]initWithID:[jsonQuestionSheet[@"ID"] integerValue]  name:jsonQuestionSheet[@"name"] timestamp:jsonQuestionSheet[@"create_date"]];
        [questionSheets addObject:questionsheet];
    }
    return questionSheets;
}

- (void) sendNotification:(NSString*)message
{
    //NSLog (@"lala");
    [[NSNotificationCenter defaultCenter]
     postNotificationName:message
     object:self];
}



@end
