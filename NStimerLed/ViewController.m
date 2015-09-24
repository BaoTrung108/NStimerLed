//
//  ViewController.m
//  NStimerLed
//
//  Created by trung bao on 25/09/2015.
//  Copyright © Năm 2015 baotrung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CGFloat _margin;
    CGFloat _ballDiameter;
    CGFloat _space;
    //int lastOnled;
    NSTimer* _timer;
    int lastOnledleft;
    int lastOnledright;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self placeballX:160 andY:150 withtag:1];
    _margin=30.0;
    _ballDiameter=48.0;
    //lastOnled=[self numberball];
    lastOnledright=-1;
    lastOnledleft=-1;
    [self drawball];
    _timer=[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(runningLed) userInfo:nil repeats: true];
}
-(void) placeballX:(CGFloat) x
              andY:(CGFloat)y
           withtag:(int)tag;
{
    UIImageView* ball=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gray"]];
    ball.center=CGPointMake(x, y);
    ball.tag= tag;
    [self.view addSubview:ball];
    //NSLog(@"%3.2f-%3.2f",ball.bounds.size.height,ball.bounds.size.width);
}
-(CGFloat) spaceball: (int) _ball {
    return (self.view.bounds.size.height-2*_margin)/(_ball-1);
}
-(void) runningLed {
    /*if (lastOnled!=[self numberball]) {
     [self turnOffLed:lastOnled];
     }if (lastOnled!=0) {
     lastOnled--;
     }else {
     lastOnled=[self numberball]-1;
     }[self turnOnLed:lastOnled];*/
    if (lastOnledleft!=[self numberball]/2+1&&lastOnledright!=[self numberball]/2) {
        [self turnOffLed:lastOnledleft];
        [self turnOffLed:lastOnledright];
    }if (lastOnledleft!=0&&lastOnledright!=[self numberball]) {
        lastOnledleft--;
        lastOnledright++;
    }else {
        lastOnledleft=[self numberball]/2+1;
        lastOnledright=[self numberball]/2;
    } [self turnOnLed:lastOnledleft];
    [self turnOnLed:lastOnledright];
}
-(void) turnOnLed : (int) index {
    UIView* view =[self.view viewWithTag:index +100];
    if (view &&[view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image =[UIImage imageNamed:@"green"];
    }
}
-(void) turnOffLed : (int) index {
    UIView* view =[self.view viewWithTag:index +100];
    if (view &&[view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image =[UIImage imageNamed:@"gray"];
    }
}
-(int) numberball {
    BOOL stop =false;
    int n=3;
    while (stop==false) {
        _space=[self spaceball:n];
        if (_space < _ballDiameter) {
            stop=true;
        } n++;
    } //NSLog(@"So bong toi da tren chieu Height la %d",n);
    return n;
}
-(void) drawball {
    int n=[self numberball];
    for (int i=0; i<= n; i++) {
        [self placeballX:180 andY:_margin +i*_space withtag:i+100];
    }
}
@end
