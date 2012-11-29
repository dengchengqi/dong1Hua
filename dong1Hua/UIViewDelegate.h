//
//  UIViewDelegate.h
//  dong1Hua
//
//  Created by Ibokan 王珂 on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewDelegate : NSObject
{
        CFRunLoopRef currentLoop;
}
-(id)initWithRunLoop:(CFRunLoopRef)runLoop;
-(void)animationFinished:(id)sender;


@end
