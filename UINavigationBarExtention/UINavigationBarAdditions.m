//
//  UINavigationBar+Custom.m
//  
//
//  Created by luobin on 5/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBarAdditions.h"
#import <objc/runtime.h>

#define TK_FIX_CATEGORY_BUG(name) @interface TK_FIX_CATEGORY_BUG_##name @end \
@implementation TK_FIX_CATEGORY_BUG_##name @end

TK_FIX_CATEGORY_BUG(UINavigationBar)

void TKReplaceMethods(Class cls, SEL originalSel, SEL newSel) {
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    method_setImplementation(originalMethod, class_getMethodImplementation(cls, newSel));
}

static char backgroundImageKey;

static UIImage *backgroundImage;

@implementation UINavigationBar (TKCategory)

+ (void)initialize
{
    TKReplaceMethods([UINavigationBar class], @selector(tempDrawRect:), @selector(drawRect:));
    TKReplaceMethods([UINavigationBar class], @selector(drawRect:), @selector(doDrawRect:));
}

+ (void)setBackgroundImage:(UIImage *)theBackgroundImage
{
    if (backgroundImage != theBackgroundImage) {
        [backgroundImage release];
        backgroundImage = [theBackgroundImage retain];
        //set navigationbar background image compatible with ios5
        if ([UINavigationBar instancesRespondToSelector:@selector(setBackgroundImage:forBarMetrics:)]
            && [UINavigationBar respondsToSelector:@selector(appearance)]) {
            [[UINavigationBar appearance] setBackgroundImage:theBackgroundImage 
                                               forBarMetrics:UIBarMetricsDefault];
        }
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    objc_setAssociatedObject(self, &backgroundImageKey, backgroundImage, OBJC_ASSOCIATION_RETAIN);
    
    //set navigationbar background image compatible with ios5
    if ([UINavigationBar instancesRespondToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self setBackgroundImage:backgroundImage
                   forBarMetrics:UIBarMetricsDefault];
    }
}

- (UIImage *)backgroundImage
{
    return objc_getAssociatedObject(self, &backgroundImageKey);
}

- (void)tempDrawRect:(CGRect)rect
{
}

- (void)doDrawRect:(CGRect)rect
{
    //解决ios4.3.3 使用MPMoviePlayerViewController 程序崩溃的情况
    if ([[[self class] description] caseInsensitiveCompare:@"MPCenteringNavigationBar"] == NSOrderedSame) {
        return;
    }
    UIImage *image = self.backgroundImage;
    if (image == nil) {
        image = backgroundImage;
    }
    if (image) {
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    } else {
        [self tempDrawRect:rect];
    }
}

@end

