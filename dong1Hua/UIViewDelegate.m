//
//  UIViewDelegate.m
//  dong1Hua
//
//  Created by Ibokan 王珂 on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewDelegate.h"

@implementation UIViewDelegate
-(id)init
{
    self=[super init];
    if (self) {
        //
    }
    return self;
}
-(id)initWithRunLoop:(CFRunLoopRef)runLoop
{
    self=[self init];
    if (self) {
        currentLoop=runLoop;
    }
    return self;
}
-(void)animationFinished:(id)sender
{
    CFRunLoopStop(currentLoop);
}


@end
