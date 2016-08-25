//
//  ViewController.m
//  bubbleHeart
//
//  Created by QianFan_Ryan on 16/8/25.
//  Copyright © 2016年 QianFan. All rights reserved.
//

#import "ViewController.h"
#import "UIView+bubbleHeart.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic,weak)NSTimer *timer;
@property (nonatomic,strong)NSDate *lastDate;
@property (nonatomic,assign)NSUInteger bubbleCount;

@end

@implementation ViewController

- (void)dealloc{
    [self cancelTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 30, kScreenHeight-30, 60, 30)];
    [button setTitle:@"Touch" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(addBubbleHeadrt:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = touches.allObjects.firstObject;
//    CGPoint location = [touch locationInView:self.view];
//    [self.view showBubbleHeartWithLocaltion:location];
//}

- (void)addBubbleHeadrt:(UIButton *)sender{
    [self.view showBubbleHeartWithLocaltion:CGPointMake(sender.center.x, sender.center.y-25)];
    _bubbleCount++;
    self.lastDate = [NSDate date];
    self.timer.fireDate = [NSDate distantPast];
}

- (NSTimer *)timer{
    if (!_timer) {
        [[NSRunLoop currentRunLoop]addTimer:(_timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES]) forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)timerAction{
    double timeInverval = [[NSDate date]timeIntervalSinceDate:self.lastDate];
    if (timeInverval > 1) {
        //do something
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"Touch count : %zd",_bubbleCount] message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        NSLog(@"touch count : %zd",_bubbleCount);
        self.timer.fireDate = [NSDate distantFuture];
        _bubbleCount = 0;
    }
}

- (void)cancelTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
