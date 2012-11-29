//
//  UIView+ModalAnimationHelper.m
//  dong1Hua
//
//  Created by Ibokan 王珂 on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+ModalAnimationHelper.h"
#import "UIViewDelegate.h"
@implementation UIView (ModalAnimationHelper)
+(void)commitModalAnimations
{
    CFRunLoopRef currentLoop=CFRunLoopGetCurrent();
    
    UIViewDelegate *uivdelegate=[[UIViewDelegate alloc]initWithRunLoop:currentLoop];
    [UIView setAnimationDelegate:uivdelegate];
    [uivdelegate release];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];
    
    CFRunLoopRun();
}
@end
