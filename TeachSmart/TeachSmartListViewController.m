//
//  TeachSmartViewController.m
//  TeachSmart
//
//  Created by Sascha Haseloff on 09/07/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import "TeachSmartListViewController.h"
#import "TeachSmartAPI.h"
#import "QuestionSheet.h"
#import "QuestionViewPageController.h"
#import "constants.h"
#import <Foundation/Foundation.h>


@interface TeachSmartListViewController (){
    //UITableView *dataTable;
    NSMutableArray  *currentQuestionSheets;
    QuestionViewPageController *activeQuestionViewPageController;
    QuestionSheet *currentQuestionSheet;
    UIActivityIndicatorView *_indicator;
    NSNotificationCenter* notificationCenter;
}



@end

@implementation TeachSmartListViewController

- (void)dealloc{
    [notificationCenter removeObserver:self];
}


- (void)viewDidLoad
{
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserverForName:nil
//                        object:nil
//                         queue:nil
//                    usingBlock:^(NSNotification *notification)
//    {
//        NSLog(@"%@", notification.name);
//    }];
    //NSLog(questionSheetsUpdateNotification);
    [super viewDidLoad];
	
    notificationCenter =  [NSNotificationCenter defaultCenter];
    
                                                
                                                
    [notificationCenter addObserver:self selector:@selector(receivedQuestionSheetsUpdate:) name:questionSheetsUpdateNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(receivedQuestionSheetLoadedNotification:)
                                                 name:questionSheetLoadedNotification
                                               object:nil];
    [notificationCenter addObserver:self
                                             selector:@selector(receivedNetworkErrorMessage:)
                                                 name:networkErrorNotification
                                               object:nil];
    
    //initdata
    [self askForTableRefresh];

    
    // This is the new stuff here ;)

    // Set the resizing mask so it's not stretched


    
    // Start it spinning! Don't miss this step
    [self.indicator startAnimating];
    

    
}

- (UIActivityIndicatorView*)indicator{
    if (!_indicator){
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicator.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleLeftMargin;
        
        // Place it in the middle of the view
        _indicator.center = self.view.center;
        
        [_indicator setBackgroundColor: [UIColor whiteColor]];
        [_indicator setColor:[UIColor blackColor]];
        
        // Add it into the spinnerView
        [self.view addSubview:_indicator];
    }
        
    return _indicator;
}

- (void)receivedNetworkErrorMessage:(NSNotification*)notification
{
//    if ([[notification name] isEqualToString:questionSheetsUpdateNotification]){
//        currentQuestionSheets = [[TeachSmartAPI sharedInstance] currentQuestionSheets];
//        [self.tableView reloadData];
//    }
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"network problem, please check server ip" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [theAlert show];
    [self.indicator stopAnimating];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = [currentQuestionSheets count];
    //NSLog(@"hallo %i", count);
    return count;
    //return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"return sth");
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    QuestionSheet *questionSheet = [currentQuestionSheets objectAtIndex:indexPath.row];
    cell.textLabel.text = [questionSheet name];
    cell.detailTextLabel.text = [questionSheet timestamp];
    return cell;
}

- (void) receivedQuestionSheetsUpdate:(NSNotification *) notification
{
    NSLog([notification name]);
    if ([[notification name] isEqualToString:questionSheetsUpdateNotification]){
        currentQuestionSheets = [[TeachSmartAPI sharedInstance] currentQuestionSheets];
        [self.tableView reloadData];
        [self.indicator stopAnimating];
    }
    

}

- (void)receivedQuestionSheetLoadedNotification:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:questionSheetLoadedNotification]){
        NSLog(@"got the quetsionsheet");
        currentQuestionSheet = [[TeachSmartAPI sharedInstance] currentQuestionSheet];
        [self performSegueWithIdentifier:@"GoToQuestionView" sender:self];
        [self.indicator stopAnimating];
    }
}


- (IBAction)refreshButtonPressed:(id)sender {
    [self askForTableRefresh];
}

- (void)askForTableRefresh
{
    [self.indicator startAnimating];
    [[TeachSmartAPI sharedInstance] getSheets];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //QuestionViewPageController *test = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionViewPageController"];
    [self.indicator startAnimating];
    QuestionSheet *questionsheet = [currentQuestionSheets objectAtIndex:indexPath.row];
    [[TeachSmartAPI sharedInstance] getSheet:questionsheet.ID];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoToQuestionView"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        activeQuestionViewPageController = segue.destinationViewController;
        //if (!currentQuestionSheet)
        //    NSLog(@"there");
        activeQuestionViewPageController.questionSheet = currentQuestionSheet;
    }
}



@end
