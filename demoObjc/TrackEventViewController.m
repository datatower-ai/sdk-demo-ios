//
//  TrackEventViewController.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "TrackEventViewController.h"
#import <Masonry/Masonry.h>
#import "DTAnalRepetitiveTrackingThread.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface TrackEventViewController ()

@property (nonatomic) UIButton *closeBtn;

@property (nonatomic) UILabel *trackName;
@property (nonatomic) UITextField *inputTrackName;

@property (nonatomic) UILabel *properties;
@property (nonatomic) UITextField *inputProperties;

@property (nonatomic) UILabel *repeates;
@property (nonatomic) UITextField *inputRepeates;

@property (nonatomic) UILabel *interval;
@property (nonatomic) UITextField *inputInterval;

@property (nonatomic) UIButton *confirmBtn;

@property (nonatomic) UIView *cancelInputView;

@end

@implementation TrackEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.cancelInputView];
    [self.cancelInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self.view addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(25);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.view addSubview:self.trackName];
    [self.trackName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.top.equalTo(self.view.mas_top).with.offset(50);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.inputTrackName];
    [self.inputTrackName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.top.equalTo(self.trackName.mas_bottom).with.offset(0);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.properties];
    [self.properties mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.top.equalTo(self.inputTrackName.mas_bottom).with.offset(25);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.inputProperties];
    [self.inputProperties mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.top.equalTo(self.properties.mas_bottom).with.offset(0);
        make.height.mas_equalTo(100);
    }];
    self.inputProperties.text = @"{\"intKey\": 123,\"strKey\": \"123\"}";
    
    [self.view addSubview:self.repeates];
    [self.repeates mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.top.equalTo(self.inputProperties.mas_bottom).with.offset(25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(screenWidth * 0.5 - 50 - 5);
    }];
    
    [self.view addSubview:self.inputRepeates];
    [self.inputRepeates mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.top.equalTo(self.repeates.mas_bottom).with.offset(5);
        make.right.equalTo(self.repeates.mas_right);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.interval];
    [self.interval mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.top.equalTo(self.inputProperties.mas_bottom).with.offset(25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(screenWidth * 0.5 - 50 - 5);
    }];
    
    [self.view addSubview:self.inputInterval];
    [self.inputInterval mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.interval.mas_right);
        make.left.equalTo(self.interval.mas_left);
        make.top.equalTo(self.repeates.mas_bottom).with.offset(5);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(25);
        make.right.equalTo(self.view.mas_right).with.offset(-25);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-100);
        make.height.mas_equalTo(50);
    }];
}

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)run:(id)sender {
    NSString *eventName = self.inputTrackName.text;
    NSString *properties = self.inputProperties.text;
    NSString *repeat = self.inputRepeates.text;
    NSString *interval = self.inputInterval.text;
    
    [[DTAnalRepetitiveTrackingThread shareInstance] start:eventName propertiesAsText:properties repeatTimes:[repeat intValue] intervalMillis:[interval intValue]];
}

- (void)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

#pragma Getter

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"Res/closeBtn"] forState:UIControlStateNormal];
//        _closeBtn.frame = CGRectMake(screenWidth - leftX - 30, leftX, 30, 30);
        [_closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UILabel *)trackName {
    if (!_trackName) {
        _trackName = [[UILabel alloc] init];
        _trackName.text = @"Event name";
    }
    return _trackName;
}

- (UITextField *)inputTrackName {
    if (!_inputTrackName) {
        _inputTrackName = [[UITextField alloc] init];
        _inputTrackName.backgroundColor = [UIColor lightGrayColor];
    }
    return _inputTrackName;
}

- (UILabel *)properties {
    if (!_properties) {
        _properties = [[UILabel alloc] init];
        _properties.text = @"Properties";
    }
    return _properties;
}

- (UITextField *)inputProperties {
    if (!_inputProperties) {
        _inputProperties = [[UITextField alloc] init];
        _inputProperties.backgroundColor = [UIColor lightGrayColor];
    }
    return _inputProperties;
}

- (UILabel *)repeates {
    if (!_repeates) {
        _repeates = [[UILabel alloc] init];
        _repeates.text = @"repeates";
    }
    return _repeates;
}

- (UITextField *)inputRepeates {
    if (!_inputRepeates) {
        _inputRepeates = [[UITextField alloc] init];
        _inputRepeates.backgroundColor = [UIColor lightGrayColor];
    }
    return _inputRepeates;
}

- (UILabel *)interval {
    if (!_interval) {
        _interval = [[UILabel alloc] init];
        _interval.text = @"interval";
    }
    return _interval;
}

- (UITextField *)inputInterval {
    if (!_inputInterval) {
        _inputInterval = [[UITextField alloc] init];
        _inputInterval.backgroundColor = [UIColor lightGrayColor];
    }
    return _inputInterval;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] init];
        _confirmBtn.layer.cornerRadius = 10;
        [_confirmBtn setTitle:@"Run" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = [UIColor blueColor];
        [_confirmBtn addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UIView *)cancelInputView {
    if (!_cancelInputView) {
        _cancelInputView = [[UIView alloc] init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
        
        [_cancelInputView addGestureRecognizer:tap];
    }
    
    return _cancelInputView;
}

@end
