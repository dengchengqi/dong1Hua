//
//  rootViewController.m
//  dong1Hua
//
//  Created by Ibokan 王珂 on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "rootViewController.h"
#import "UIView+ModalAnimationHelper.h"
#import <QuartzCore/QuartzCore.h>

static const CGPoint kBTSPathEndPoint={300.0,300.0};//结尾的点

@implementation rootViewController
//@synthesize bigImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    //建立的一个view覆盖了
    UIView *aView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [aView setBackgroundColor:[UIColor grayColor]];
    self.view=aView;
    [aView release];
    
    
    
    //建立了操作view
    UIView *bView=[[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    bView.backgroundColor=[UIColor redColor];
    [self.view addSubview:bView];
    [bView release];
    
//    self.view=[[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds]autorelease];
//    bigImage=[[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 100, 200)];
//    NSString *str=[[NSBundle mainBundle]pathForResource:@"气球" ofType:@"png"];
//    bigImage.image=[UIImage imageWithContentsOfFile:str];
//    [self.view addSubview:bigImage];
//    [bigImage release];
    
    {
    path=CGPathCreateMutable();//创建一个可变路线
    CGPathMoveToPoint(path, NULL, 15.0, 15.0);//起点
    CGPathAddLineToPoint(path, NULL, 100.0, 100.0);//直线到这个点
    CGPathAddArc(path, NULL, 100.0, 100.0, 75.0, 0.0, (CGFloat)M_PI, 1);//半圆 圆心（100，100）   半径75  角度0到PI 是否顺时针（1）
    CGPathAddLineToPoint(path, NULL, 200.0  ,150.0 );//直线到这个点
    CGPathAddCurveToPoint(path, NULL, 150.0, 150.0, 50.0, 350.0, kBTSPathEndPoint.x,kBTSPathEndPoint.y);
    }
    
    CALayer *layer=[CALayer layer];
    
    [layer setShadowColor:[UIColor redColor].CGColor];//层的阴影
    [layer setContents:(__bridge id)[UIImage imageNamed:@"Icon.png"].CGImage];
    [layer setBounds:CGRectMake(0.0, 0.0, 30, 30)];
    [layer setPosition:CGPointMake(15.0, 15.0)];
    [layer setShadowPath:[UIBezierPath bezierPathWithRect:[layer bounds]].CGPath];
    [layer setShadowOpacity:1];
    [layer setShadowOffset:CGSizeMake(5.0, 5.0)];
    
    [[[self view]layer]addSublayer:layer];
    
    [self addPathAnimationToLayer:layer shouldRepeat:YES];
    
    [[[self view] layer] setContentsScale:[[UIScreen mainScreen] scale]];
    [[[self view] layer] setDelegate:self];
    [[[self view] layer] setNeedsDisplay];
    

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    

    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{  
    CGContextAddPath(ctx, path);
    CGContextSetShadow(ctx, CGSizeMake(2.5, 2.5), 2.0);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextStrokePath(ctx);
}



- (IBAction)updateAnimation:(id)sender {
    BOOL shouldRepeat = [(UISwitch *)sender isOn];
    
    CALayer *layer = [[[[self view] layer] sublayers] objectAtIndex:0];
    [self addPathAnimationToLayer:layer shouldRepeat:shouldRepeat];
}



- (void)addPathAnimationToLayer:(CALayer *)layer shouldRepeat:(BOOL)shouldRepeat
{
    [layer removeAllAnimations];
    
    // To animate along a path is drop-dead easy. 
    // - Create a "key frame animation" for the "position"
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [animation setPath:path]; // here is the magic!
    [animation setDuration:2.5];
    
    [animation setCalculationMode:kCAAnimationCubic];
    [animation setRotationMode:kCAAnimationRotateAuto]; // pass nil to turn off rotation model
    
    if (shouldRepeat) {
        [animation setAutoreverses:YES];
        [animation setRepeatCount:MAXFLOAT];
    } else {
        [animation setAutoreverses:NO];
        [animation setRepeatCount:1];

        [layer setPosition:kBTSPathEndPoint];
    }
    
    // Start animating the layer along the path.
    //
    // Important Note:
    // Every layer maintains a map of animations keyed by various property values. 
    // In this case, the key frame animation replaces the "implicit property" animation.
    // This is important in order to override any existing implicit animation caused 
    // by setting the layer's position. 
    [layer addAnimation:animation forKey:@"position"];
    
    
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
//    bigImage=(UIImageView *)touch.view;
//    BOOL a=( touch.view.frame.origin.x==bigImage.frame.origin.x);
//    if (a) {
//    CGAffineTransform transform;
//    transform=CGAffineTransformTranslate(bigImage.transform, 10.0, 10.0);//当前位置移动
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.2];
//    [bigImage setTransform:transform];
//    [UIView commitModalAnimations];
//    
//    CGAffineTransform transform1;
//    transform1=CGAffineTransformRotate(bigImage.transform, M_PI/6.0);//根据目标对象 当前的 transform进行旋转
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:2];
//    [bigImage setTransform:transform1];//变化
//    [UIView setAnimationDelegate:self];
//    [UIView commitModalAnimations];
//
//    CGAffineTransform transform2;
//    transform2=CGAffineTransformScale(bigImage.transform, 1.2, 1.2);
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.2];
//    [bigImage setTransform:transform2];
//    [UIView commitModalAnimations];
//
//    }
    
    UIView *bView=touch.view;
    //view的两个动画
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1];
    bView.transform=CGAffineTransformMakeScale(50.0f, 50.0f);
    [UIView commitModalAnimations];
    
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2];
    bView.transform=CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitModalAnimations];
    
}






- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
