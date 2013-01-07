//
//  TKMasterViewController.h
//  UINavigationBarExtention
//
//  Created by LuoBin on 13-1-7.
//  Copyright (c) 2013年 LuoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKDetailViewController;

@interface TKMasterViewController : UITableViewController

@property (strong, nonatomic) TKDetailViewController *detailViewController;

@end
