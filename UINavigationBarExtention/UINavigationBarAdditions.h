
//
//  UINavigationBar+Custom.h
//  
//
//  Created by luobin on 5/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationBar (TKCategory)

@property (nonatomic, retain) UIImage *backgroundImage;

+ (void)setBackgroundImage:(UIImage *)backgroundImage;

@end
