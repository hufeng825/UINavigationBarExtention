//
//  TKDetailViewController.h
//  UINavigationBarExtention
//
//  Created by LuoBin on 13-1-7.
//  Copyright (c) 2013年 LuoBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
