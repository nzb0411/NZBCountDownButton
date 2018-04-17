//
//  NZBCountDownButton.h
//  NZBCountDownButton
//
//  Created by Niezibo on 2018/4/15.
//  Copyright © 2018年 聂子博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NZBCountDownButton : UIButton

- (instancetype)initWithFrame:(CGRect) frame
              backgroundColor:(UIColor *) backgroundColor
                   titleColor:(UIColor *) titleColor
                 defaultTitle:(NSString *) defaultTitle
                     duration:(NSInteger) duration
                buttonClicked:(void(^)(void)) buttonClicked
               countDownStart:(void(^)(void)) countDownStart
            countDownUnderway:(void(^)(NSInteger restCountDownNum)) countDownUnderway
          countDownCompletion:(void(^)(void)) countDownCompletion;

- (void) startCountDown;

@end
