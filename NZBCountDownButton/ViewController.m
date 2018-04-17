//
//  ViewController.m
//  NZBCountDownButton
//
//  Created by Niezibo on 2018/4/15.
//  Copyright © 2018年 聂子博. All rights reserved.
//

#import "ViewController.h"
#import "NZBCountDownButton.h"

#define SCREEN_FRAME  [UIScreen mainScreen].bounds
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) NZBCountDownButton *countDownButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __weak __typeof__(self) weakSelf = self;
    
    self.countDownButton = [[NZBCountDownButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2 - 25, 200, 50)
                                                     backgroundColor:[UIColor blackColor]
                                                          titleColor:[UIColor whiteColor]
                                                        defaultTitle:@"获取验证码"
                                                            duration:11
                                                       buttonClicked:^{
                                                           
                                                           [weakSelf.countDownButton startCountDown];
                                                           
                                                       } countDownStart:^{
                                                           
                                                           /** 倒计时开始 */
                                                           
                                                       } countDownUnderway:^(NSInteger restCountDownNum) {
                                                           
                                                           /** 倒计时中 */
                                                           [weakSelf.countDownButton setTitle:[NSString stringWithFormat:@"%ld", restCountDownNum] forState:UIControlStateNormal];
                                                           
                                                       } countDownCompletion:^{
                                                           
                                                           /** 倒计时结束 */
                                                           [weakSelf.countDownButton setTitle:@"重新获取" forState:UIControlStateNormal];
                                                       }];
    
    [self.view addSubview:self.countDownButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
