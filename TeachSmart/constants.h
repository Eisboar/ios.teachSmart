//
//  constants.h
//  TeachSmart
//
//  Created by Sascha Haseloff on 31/07/14.
//  Copyright (c) 2014 Sascha Haseloff. All rights reserved.
//

#ifndef TeachSmart_constants_h
#define TeachSmart_constants_h

//restfull server bse url
#define baseURL @"http://127.0.0.1:8081/wanda.backend/"

//restfull task interfaces
#define getSheetsTask @"getSheets"
#define getSheetTask @"getSheet"


//notifications
#define networkErrorNotification @"networkErrorOccured"
#define questionSheetsUpdateNotification @"questionSheetsUpdateNotification"
#define questionSheetLoadedNotification @"questionSheetLoadedNotification"

//questionview
#define x_view_padding 10.00f
#define y_view_padding 20.00f
#define y_navbar_height 66.00f

//ratingview
#define star_count 5

enum network_tasks{
    getSheets,
    getSheet
};

typedef enum network_tasks NetworkTasks;


#endif

@interface constants: NSObject

@end






