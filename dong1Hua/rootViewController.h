//
//  rootViewController.h
//  dong1Hua
//
//  Created by Ibokan 王珂 on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rootViewController : UIViewController
{
    UIImageView *bigImage;
    
    CGMutablePathRef path;
}
- (void)addPathAnimationToLayer:(CALayer *)layer shouldRepeat:(BOOL)shouldRepeat;

//@property(retain,nonatomic)UIImageView *bigImage;
@end
