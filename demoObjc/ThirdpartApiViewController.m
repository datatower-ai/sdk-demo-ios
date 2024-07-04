//
//  ThirdpartApiViewController.m
//  demoObjc
//
//  Created by Lilin on 2024/7/4.
//

#import "ThirdpartApiViewController.h"
#import <Masonry/Masonry.h>
#import <DataTowerAICore/DTAnalytics.h>
#import <DataTowerAICore/DTAdReport.h>
#import <DataTowerAICore/DTAnalyticsUtils.h>
#import <DataTowerAICore/DTIAPReport.h>
#import <DataTowerAICore/DTIASReport.h>
#import <objc/runtime.h>
#import <QMUIKit/QMUITips.h>

extern const CGFloat startX;
extern const NSString *star;
#define controlWidth  ([UIScreen mainScreen].bounds.size.width - leftX * 2)
#define alignTop(topView, nextView, height)  nextView.frame = CGRectMake(leftX, CGRectGetMinY(topView.frame) + CGRectGetHeight(topView.frame) + 10, controlWidth, height);

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface ThirdpartApiViewController ()

@property (nonatomic) UIButton *closeBtn;
@property (nonatomic) UIScrollView *contentView;

@property (nonatomic) UIView *firebaseCell;
@property (nonatomic) UITextView *firebaseId;
@property (nonatomic) UIButton *firebaseSet;


@property (nonatomic) UIView *appsFlyerCell;
@property (nonatomic) UITextView *appsFlyerId;
@property (nonatomic) UIButton *appsFlyerSet;

@property (nonatomic) UIView *adjustrCell;
@property (nonatomic) UITextView *adjustId;
@property (nonatomic) UIButton *adjustSet;

@property (nonatomic) UIView *kochavaCell;
@property (nonatomic) UITextView *kochavaId;
@property (nonatomic) UIButton *kochavaSet;

@end

@implementation ThirdpartApiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.closeBtn];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(self.closeBtn.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
    }];
    
    [self.contentView addSubview:self.firebaseCell];
    [self.firebaseCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.height.mas_equalTo(50);
//        make.width.mas_equalTo(screenWidth - 40);
    }];
    
    [self.contentView addSubview:self.appsFlyerCell];
    [self.appsFlyerCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.firebaseCell.mas_bottom).with.offset(10);
        make.height.mas_equalTo(50);
//        make.width.mas_equalTo(screenWidth - 40);
    }];
    
    [self.contentView addSubview:self.adjustrCell];
    [self.adjustrCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.appsFlyerCell.mas_bottom).with.offset(10);
        make.height.mas_equalTo(50);
//        make.width.mas_equalTo(screenWidth - 40);
    }];
    
    [self.contentView addSubview:self.kochavaCell];
    [self.kochavaCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.adjustrCell.mas_bottom).with.offset(10);
        make.height.mas_equalTo(50);
//        make.width.mas_equalTo(screenWidth - 40);
    }];
    
    [self loadData];
}

#pragma mark data load

- (void)loadData {
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"ThirePartySaveKey"];
    
    _firebaseId.text = dict[@"#firebase_iid"];;
    _appsFlyerId.text = dict[@"#appsflyer_id"];
    _adjustId.text = dict[@"#adjust_id"];
    _kochavaId.text = dict[@"#kochava_id"];
}

#pragma mark event handle

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setFirebaseId:(id)sender {
    
    NSString *txtId = _firebaseId.text;
    if ([txtId isEqualToString:@""]) {
        txtId = nil;
    }
  
    [DTAnalytics setFirebaseAppInstanceId:txtId];
    
    [QMUITips showInfo:@"设置成功" inView:[UIApplication sharedApplication].keyWindow].userInteractionEnabled = NO;
}

- (void)setAppsFlyerId:(id)sender {
    NSString *txtId = _appsFlyerId.text;
    if ([txtId isEqualToString:@""]) {
        txtId = nil;
    }
    
    [DTAnalytics setAppsFlyerId:txtId];
    
    [QMUITips showInfo:@"设置成功" inView:[UIApplication sharedApplication].keyWindow].userInteractionEnabled = NO;
}

- (void)setAdjustId:(id)sender {
    NSString *txtId = _adjustId.text;
    if ([txtId isEqualToString:@""]) {
        txtId = nil;
    }
    
    [DTAnalytics setAdjustId:txtId];
    
    [QMUITips showInfo:@"设置成功" inView:[UIApplication sharedApplication].keyWindow].userInteractionEnabled = NO;
}

- (void)setKochavaId:(id)sender {
    NSString *txtId = _kochavaId.text;
    if ([txtId isEqualToString:@""]) {
        txtId = nil;
    }
    
    [DTAnalytics setKochavaId:txtId];
    
    [QMUITips showInfo:@"设置成功" inView:[UIApplication sharedApplication].keyWindow].userInteractionEnabled = NO;
}

#pragma mark -- View create

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"Res/closeBtn"] forState:UIControlStateNormal];
        _closeBtn.frame = CGRectMake(screenWidth - startX - 30, startX, 30, 30);
        [_closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
    }
    return _contentView;
}

- (UIView *)firebaseCell {
    
    if(!_firebaseCell) {
        _firebaseCell = [[UIView alloc] init];
        _firebaseCell.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"firebase id";
        [title sizeToFit];
        [_firebaseCell addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_firebaseCell.mas_left).with.offset(10);
            make.centerY.equalTo(_firebaseCell.mas_centerY);
        }];
        
        _firebaseId = [[UITextView alloc] init];
        _firebaseId.editable = YES;
        [_firebaseCell addSubview:_firebaseId];
        [_firebaseId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).with.offset(20);
            make.centerY.equalTo(title.mas_centerY);
            make.top.equalTo(_firebaseCell.mas_top).with.offset(10);
            make.bottom.equalTo(_firebaseCell.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(100);
//            make.height.mas_equalTo(50);
        }];
        
        _firebaseSet = [[UIButton alloc] init];
        [_firebaseSet setTitle:@"确定" forState:UIControlStateNormal];
        _firebaseSet.backgroundColor = [UIColor darkGrayColor];
        [_firebaseSet addTarget:self action:@selector(setFirebaseId:) forControlEvents:UIControlEventTouchUpInside];
        [_firebaseCell addSubview:_firebaseSet];
        [_firebaseSet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_firebaseId.mas_right).with.offset(20);
            make.centerY.equalTo(_firebaseId.mas_centerY);
            make.top.equalTo(_firebaseCell.mas_top).with.offset(10);
            make.bottom.equalTo(_firebaseCell.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(50);
        }];
    }
    
    return _firebaseCell;
}

- (UIView *)appsFlyerCell {
    
    if(!_appsFlyerCell) {
        _appsFlyerCell = [[UIView alloc] init];
        _appsFlyerCell.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"AppsFlyer id";
        [title sizeToFit];
        [_appsFlyerCell addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_appsFlyerCell.mas_left).with.offset(10);
            make.centerY.equalTo(_appsFlyerCell.mas_centerY);
        }];
        
        _appsFlyerId = [[UITextView alloc] init];
        _appsFlyerId.editable = YES;
        [_appsFlyerCell addSubview:_appsFlyerId];
        [_appsFlyerId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).with.offset(20);
            make.centerY.equalTo(title.mas_centerY);
            make.top.equalTo(_appsFlyerCell.mas_top).with.offset(10);
            make.bottom.equalTo(_appsFlyerCell.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(100);
//            make.height.mas_equalTo(50);
        }];
        
        _appsFlyerSet = [[UIButton alloc] init];
        [_appsFlyerSet setTitle:@"确定" forState:UIControlStateNormal];
        _appsFlyerSet.backgroundColor = [UIColor darkGrayColor];
        [_appsFlyerSet addTarget:self action:@selector(setAppsFlyerId:) forControlEvents:UIControlEventTouchUpInside];
        [_appsFlyerCell addSubview:_appsFlyerSet];
        [_appsFlyerSet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_appsFlyerId.mas_right).with.offset(20);
            make.centerY.equalTo(_appsFlyerId.mas_centerY);
            make.top.equalTo(_appsFlyerCell.mas_top).with.offset(10);
            make.bottom.equalTo(_appsFlyerCell.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(50);
        }];
    }
    
    return _appsFlyerCell;
}

- (UIView *)adjustrCell {
    
    if(!_adjustrCell) {
        _adjustrCell = [[UIView alloc] init];
        _adjustrCell.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"Adjust id";
        [title sizeToFit];
        [_adjustrCell addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_adjustrCell.mas_left).with.offset(10);
            make.centerY.equalTo(_adjustrCell.mas_centerY);
        }];
        
        _adjustId = [[UITextView alloc] init];
        _adjustId.editable = YES;
        [_adjustrCell addSubview:_adjustId];
        [_adjustId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).with.offset(20);
            make.centerY.equalTo(title.mas_centerY);
            make.top.equalTo(_adjustrCell.mas_top).with.offset(10);
            make.bottom.equalTo(_adjustrCell.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(100);
//            make.height.mas_equalTo(50);
        }];
        
        _adjustSet = [[UIButton alloc] init];
        [_adjustSet setTitle:@"确定" forState:UIControlStateNormal];
        _adjustSet.backgroundColor = [UIColor darkGrayColor];
        [_adjustSet addTarget:self action:@selector(setAdjustId:) forControlEvents:UIControlEventTouchUpInside];
        [_adjustrCell addSubview:_adjustSet];
        [_adjustSet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_adjustId.mas_right).with.offset(20);
            make.centerY.equalTo(_adjustId.mas_centerY);
            make.top.equalTo(_adjustrCell.mas_top).with.offset(10);
            make.bottom.equalTo(_adjustrCell.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(50);
        }];
    }
    
    return _adjustrCell;
}

- (UIView *)kochavaCell {
    
    if(!_kochavaCell) {
        _kochavaCell = [[UIView alloc] init];
        _kochavaCell.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"Kochava id";
        [title sizeToFit];
        [_kochavaCell addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_kochavaCell.mas_left).with.offset(10);
            make.centerY.equalTo(_kochavaCell.mas_centerY);
        }];
        
        _kochavaId = [[UITextView alloc] init];
        _kochavaId.editable = YES;
        [_kochavaCell addSubview:_kochavaId];
        [_kochavaId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).with.offset(20);
            make.centerY.equalTo(title.mas_centerY);
            make.top.equalTo(_kochavaCell.mas_top).with.offset(10);
            make.bottom.equalTo(_kochavaCell.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(100);
//            make.height.mas_equalTo(50);
        }];
        
        _kochavaSet = [[UIButton alloc] init];
        [_kochavaSet setTitle:@"确定" forState:UIControlStateNormal];
        _kochavaSet.backgroundColor = [UIColor darkGrayColor];
        [_kochavaSet addTarget:self action:@selector(setKochavaId:) forControlEvents:UIControlEventTouchUpInside];
        [_kochavaCell addSubview:_kochavaSet];
        [_kochavaSet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_kochavaId.mas_right).with.offset(20);
            make.centerY.equalTo(_kochavaId.mas_centerY);
            make.top.equalTo(_kochavaCell.mas_top).with.offset(10);
            make.bottom.equalTo(_kochavaCell.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(50);
        }];
    }
    
    return _kochavaCell;
}

@end
