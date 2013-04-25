//
//  TWStatus.m
//  Office24TH
//
//  Created by Thanakrit Weekhamchai on 3/21/13.
//  Copyright (c) 2013 Clbs Ltd. All rights reserved.
//

#import "TWStatus.h"

@interface TWStatus (){
    UIWindow *_statusWindow;
    UIView *_backgroundView;
    UILabel *_statusLabel;
    UILabel *_checkLabel;
    
    UIActivityIndicatorView *_activityIndicator;
}

@end

@implementation TWStatus

- (id)init{
    self = [super init];
    if (self) {
        [self setupDefaultApperance];
    }
    return self;
}

- (void)setupDefaultApperance{
    _statusWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    _statusWindow.windowLevel = UIWindowLevelStatusBar;
    _statusWindow.backgroundColor = [UIColor blackColor];
    _statusWindow.alpha = 0.0;
    
    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    _backgroundView.backgroundColor = [UIColor clearColor];
    _backgroundView.alpha = 0.0;
    
    _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    _statusLabel.backgroundColor = [UIColor clearColor];
    _statusLabel.textColor = [UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0];
    _statusLabel.font = [UIFont boldSystemFontOfSize:13];
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    _statusLabel.numberOfLines = 1;
    
    _checkLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _checkLabel.text = @"\u2714";
    _checkLabel.backgroundColor = [UIColor clearColor];
    _checkLabel.textColor = [UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0];
    _checkLabel.font = [UIFont fontWithName:@"Arial Unicode MS" size:13.0];
    _checkLabel.textAlignment = NSTextAlignmentCenter;
    _checkLabel.numberOfLines = 1;
    _checkLabel.hidden = YES;
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    _activityIndicator.transform = CGAffineTransformMakeScale(0.6, 0.6);
    _activityIndicator.frame = CGRectMake(0, 0, 20, 20);
    _activityIndicator.hidesWhenStopped = YES;
    
    [_backgroundView addSubview:_statusLabel];
    [_backgroundView addSubview:_checkLabel];
    [_backgroundView addSubview:_activityIndicator];
    
    [_statusWindow addSubview:_backgroundView];
}

+ (id)sharedTWStatus{
    
    static TWStatus *_sharedTWStatus = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTWStatus = [[TWStatus alloc] init];
    });
    
    return _sharedTWStatus;
}

+ (void)showLoadingWithStatus:(NSString *)status{
    [[TWStatus sharedTWStatus] showLoadingWithStatus:status];
}

+ (void)showStatus:(NSString *)status{
    [[TWStatus sharedTWStatus] showStatus:status withCheck:NO];
}

+ (void)showStatusWithCheck:(NSString *)status{
    [[TWStatus sharedTWStatus] showStatus:status withCheck:YES];
}

+ (void)dismiss{
    [[TWStatus sharedTWStatus] dismiss];
}

+ (void)dismissAfter:(NSTimeInterval)interval{
    [[TWStatus sharedTWStatus] dismissAfter:interval];
}

#pragma mark - private
- (void)showLoadingWithStatus:(NSString *)status{
    
    if (_statusWindow.hidden) {
        
        [self setStatus:status];
        _statusWindow.hidden = NO;

        [_activityIndicator startAnimating];
        
        [UIView animateWithDuration:0.2 animations:^{
            _statusWindow.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.05 animations:^{
                _backgroundView.alpha = 1.0;
            }];
        }];
        
    }else{
        
        [UIView animateWithDuration:0.1 animations:^{
            _backgroundView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self setStatus:status];
            [_activityIndicator startAnimating];

            [UIView animateWithDuration:0.1 animations:^{
                _backgroundView.alpha = 1.0;
                
            }];
        }];
    }
}

- (void)showStatus:(NSString *)status withCheck:(BOOL)check{
    
    _checkLabel.hidden = !check;

    [_activityIndicator stopAnimating];
    
    if (_statusWindow.hidden) {
        
        [self setStatus:status];
        _statusWindow.hidden = NO;
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _statusWindow.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.05 animations:^{
                
                _backgroundView.alpha = 1.0;
                
            }];
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.1 animations:^{
            
            _backgroundView.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            _activityIndicator.alpha = 1.0;
            [self setStatus:status];
            
            [UIView animateWithDuration:0.1 animations:^{
                
                _backgroundView.alpha = 1.0;
                
            }];
        }];
    }

}


- (void)dismiss{
    
    [UIView animateWithDuration:0.05 animations:^{
        
        _backgroundView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _statusWindow.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            _statusWindow.hidden = YES;
            [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
        }];
    }];
}

- (void)dismissAfter:(NSTimeInterval)interval{

    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self dismiss];
    });
}

#pragma mark - properties
- (void)setStatus:(NSString *)status{
    _status = status;
    _statusLabel.text = status;
    
    [self layout];
}

- (void)layout{
    
    CGSize size = [_status sizeWithFont:_statusLabel.font forWidth:320 lineBreakMode:_statusLabel.lineBreakMode];
 
    CGRect statusLabelFrame = _statusLabel.frame;
    statusLabelFrame.size.width = size.width;
    
    if (_activityIndicator.isAnimating || !_checkLabel.isHidden) {
        statusLabelFrame.origin.x += 10;
    }
    _statusLabel.frame = statusLabelFrame;
    _statusLabel.center = _backgroundView.center;
    
    CGRect activityFrame = _activityIndicator.frame;
    activityFrame.origin.x = CGRectGetMinX(_statusLabel.frame) - 20;
    _activityIndicator.frame = activityFrame;

    CGRect checkFrame = _checkLabel.frame;
    checkFrame.origin.x = CGRectGetMinX(_statusLabel.frame) - 20;
    _checkLabel.frame = checkFrame;

}

@end
