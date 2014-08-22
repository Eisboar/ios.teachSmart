//
//  TeachSmartViewController.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 09/07/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpClient.h"

@interface TeachSmartListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)refreshButtonPressed:(id)sender;
- (void) loadListView;

@end
