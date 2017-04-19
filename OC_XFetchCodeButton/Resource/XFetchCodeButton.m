
//
//  XFetchCodeButton.m
//  XFetchCodeButton
//
//  Created by 王雄皓 on 2017/4/19.
//  Copyright © 2017年 王雄皓. All rights reserved.
//

#import "XFetchCodeButton.h"

@implementation XFetchCodeButton
{
    NSTimer *_timer; // 定时器
    UIButton *_codeBtn; // 倒计时按钮
    
    int _timerCount;
    id _pBlock;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setNormalTitle:(NSString *)normalTitle {
    
    _normalTitle = normalTitle;
    [_codeBtn setTitle:_normalTitle forState:UIControlStateNormal];
}

- (void)setNormalTintColor:(UIColor *)normalTintColor {
    
    _normalTintColor = normalTintColor;
    [_codeBtn setTitleColor:_normalTintColor forState:UIControlStateNormal];
}

- (void)setDisabledColor:(UIColor *)disabledColor {
    
    _disabledColor = disabledColor;
    [_codeBtn setTitleColor:_disabledColor forState:UIControlStateDisabled];
}


- (void)setFontSize:(CGFloat)fontSize {
    
    _fontSize = fontSize;
    [_codeBtn.titleLabel setFont:[UIFont systemFontOfSize:_fontSize]];
}


- (void)setupUI {
    
    self.normalTitle = @"获取验证码";
    self.normalTintColor = [UIColor blueColor];
    self.fontSize = 10;
    self.disabledColor = [UIColor grayColor];
    _timerCount = CountDownDefault;
    
    _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_codeBtn setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_codeBtn setTitle:self.normalTitle forState:UIControlStateNormal];
    [_codeBtn setTitleColor:self.normalTintColor forState:UIControlStateNormal];
    [_codeBtn setTitleColor:self.disabledColor forState:UIControlStateDisabled];
    [_codeBtn setBackgroundColor:[UIColor clearColor]];
    [_codeBtn.titleLabel setFont:[UIFont systemFontOfSize:self.fontSize]];
    [_codeBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_codeBtn];
    
}

- (void)addTarget:(id)target action:(SEL)sel forEvents:(UIControlEvents)events {
    
    [_codeBtn addTarget:target action:sel forControlEvents:events];
}

- (void)doneSend:(void (^)())block {
    
    _pBlock = block;
}

- (void)send {
    
    if (_pBlock) {
        ((void(^)())_pBlock)();
    }
    
    [_codeBtn setEnabled:false];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(start:) userInfo:nil repeats:true];
    
}

- (void)stop {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        _timerCount = CountDownDefault;
    }
}

- (void)start:(NSTimer *)ti {
    __weak typeof(self) __weakSelf = self;

    if (_timerCount == 1) {
        
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
        
        _timerCount = CountDownDefault;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_codeBtn setEnabled:true];
            [_codeBtn setTitle:__weakSelf.normalTitle forState:UIControlStateNormal];
        });
        return;
    }
    
    _timerCount -= 1;
    NSString * old = [CountDown copy];
    NSString * new = [[[NSString alloc] initWithFormat:@"%d", _timerCount] stringByAppendingString:old];

    dispatch_async(dispatch_get_main_queue(), ^{
        [_codeBtn setTitle:new forState:UIControlStateNormal];
    });
}

@end
