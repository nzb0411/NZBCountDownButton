//
//  NZBCountDownButton.m
//  NZBCountDownButton
//
//  Created by Niezibo on 2018/4/15.
//  Copyright © 2018年 聂子博. All rights reserved.
//

#import "NZBCountDownButton.h"
#import <MSWeakTimer.h>

typedef void(^ButtonClickedBlock) (void);
typedef void(^CountDownStartBlock) (void);
typedef void(^CountDownUnderwayBlock) (NSInteger restCountDownNum);
typedef void(^CountDownCompletionBlock) (void);

@interface NZBCountDownButton ()

/** 控制倒计时的timer */
@property (nonatomic, strong) MSWeakTimer *timer;
/** 按钮点击事件的回调 */
@property (nonatomic, copy) ButtonClickedBlock buttonClickedBlock;
/** 倒计时开始的回调 */
@property (nonatomic, copy) CountDownStartBlock countDownStartBlock;
/** 倒计时进行中的回调（每秒一次） */
@property (nonatomic, copy) CountDownUnderwayBlock countDownUnderwayBlock;
/** 倒计时完成时的回调 */
@property (nonatomic, copy) CountDownCompletionBlock countDownCompletionBlock;

@end

@implementation NZBCountDownButton
{
    /** 倒计时开始值 */
    NSInteger _startCountDownNum;
    /** 倒计时剩余值 */
    NSInteger _restCountDownNum;
}

- (instancetype)initWithFrame:(CGRect) frame
              backgroundColor:(UIColor *) backgroundColor
                   titleColor:(UIColor *) titleColor
                 defaultTitle:(NSString *) defaultTitle
                     duration:(NSInteger) duration
                buttonClicked:(void(^)(void)) buttonClicked
               countDownStart:(void(^)(void)) countDownStart
            countDownUnderway:(void(^)(NSInteger restCountDownNum)) countDownUnderway
          countDownCompletion:(void(^)(void)) countDownCompletion;
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = backgroundColor;
        [self setTitle:defaultTitle forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        
        _startCountDownNum = duration;
        self.buttonClickedBlock = buttonClicked;
        self.countDownStartBlock = countDownStart;
        self.countDownUnderwayBlock = countDownUnderway;
        self.countDownCompletionBlock = countDownCompletion;
        
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

/** 点击按钮 */
- (void) buttonClicked:(NZBCountDownButton *) sender
{
    sender.enabled = NO;
    self.buttonClickedBlock();
}

/** 开始倒计时 */
- (void) startCountDown
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    _restCountDownNum = _startCountDownNum;
    self.countDownStartBlock();
    self.timer = [MSWeakTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(refreshButton)
                                                    userInfo:nil
                                                     repeats:YES
                                               dispatchQueue:dispatch_get_main_queue()];
}

/** 刷新按钮title */
- (void) refreshButton
{
    _restCountDownNum --;
    
    self.countDownUnderwayBlock(_restCountDownNum);
    
    if (_restCountDownNum == 0)
    {
        [self.timer invalidate];
        self.timer = nil;
        _restCountDownNum = _startCountDownNum;
        self.countDownCompletionBlock();
        self.enabled = YES;
    }
}

@end
