//
//  ViewController.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "ViewController.h"
#import <DataTowerAICore/DTAnalytics.h>
#import "Datasource.h"
#import "CellViewModel.h"
#import "CustomCell.h"
#import <QMUIKit/QMUITips.h>
#import <Masonry/Masonry.h>
#import <DataTowerAICore/DT.h>
#import "DTDemoViewController.h"

@interface ViewController ()

@property (nonatomic) UIView *appIdInfoView;
@property (nonatomic) UITextView *appId;

@property (nonatomic) UIView *serverUrlInfoView;
@property (nonatomic) UITextView *serverUrl;

@property (nonatomic) UIView *isDebugView;
@property (nonatomic) UISwitch *isDebug;

@property (nonatomic) UIView *enablTrack;
@property (nonatomic) UISwitch *isEnableTrack;

@property (nonatomic) UIButton *confirm;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.appIdInfoView];
    [self.appIdInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.serverUrlInfoView];
    [self.serverUrlInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.appIdInfoView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.isDebugView];
    [self.isDebugView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.serverUrlInfoView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.enablTrack];
    [self.enablTrack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.isDebugView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(50);
    }];


    [self.view addSubview:self.confirm];
    [self.confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    

    
    [self loadData];
}

- (void)loadData {
    NSString *cacheAppId = [[NSUserDefaults standardUserDefaults] objectForKey:@"demo_appId"];
    NSString *cacheServerUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"demo_serverUrl"];
    
    if(!cacheAppId || [cacheAppId isEqualToString:@""]) {
        cacheAppId = @"dt_1942e70da5bfd73b";
    }
    
    if (!cacheServerUrl || [cacheServerUrl isEqualToString:@""]) {
        cacheServerUrl = @"https://test.roiquery.com";
    }
    
    self.appId.text = cacheAppId;
    self.serverUrl.text = cacheServerUrl;
    [self.isDebug setOn:YES animated:NO];
    [self.isEnableTrack setOn:YES animated:NO];
}

- (void)savaData:(NSString *)appId serverUrl:(NSString *)serverUrl {
    [[NSUserDefaults standardUserDefaults] setObject:appId forKey:@"demo_appId"];
    [[NSUserDefaults standardUserDefaults] setObject:serverUrl forKey:@"demo_serverUrl"];
}

- (void)initSDK:(id)sender {
    
    NSString *appId = self.appId.text;
    NSString *serverUrl = self.serverUrl.text;
    BOOL isDebug = self.isDebug.isOn;
    BOOL enableTrack = self.isEnableTrack.isOn;
    
    if ([appId isEqualToString:@""] || [serverUrl isEqualToString:@""]) {
        return;
    }
    
    [DT initSDK:appId serverUrl:serverUrl channel:DTChannelAppStore isDebug:isDebug logLevel:DTLoggingLevelDebug enableTrack:enableTrack];
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self savaData:appId serverUrl:serverUrl];
    });
    
    DTDemoViewController *vc = [[DTDemoViewController alloc] init];
    vc.appId = appId;
    vc.serverUrl = serverUrl;
    vc.isDebug = isDebug;
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

#pragma Getter

- (UIButton *)confirm {
    if(!_confirm) {
        _confirm = [[UIButton alloc] init];
        _confirm.backgroundColor = [UIColor systemBlueColor];
        _confirm.layer.cornerRadius = 10;
        [_confirm setTitle:@"初始化" forState:UIControlStateNormal];
        [_confirm addTarget:self action:@selector(initSDK:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirm;
}

- (UIView *)appIdInfoView {
    if (!_appIdInfoView) {
        _appIdInfoView = [[UIView alloc] init];
        _appIdInfoView.backgroundColor = [UIColor lightGrayColor];

        UILabel *title = [[UILabel alloc] init];
        title.text = @"app id";
        [title sizeToFit];
        [_appIdInfoView addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_appIdInfoView.mas_left).with.offset(10);
            make.centerY.equalTo(_appIdInfoView.mas_centerY);
        }];
        
        _appId = [[UITextView alloc] init];
        _appId.editable = YES;
        [_appIdInfoView addSubview:_appId];
        [_appId mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).with.offset(20);
            make.centerY.equalTo(title.mas_centerY);
            make.top.equalTo(_appIdInfoView.mas_top).with.offset(10);
            make.bottom.equalTo(_appIdInfoView.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(200);
//            make.height.mas_equalTo(50);
        }];
    }
    
    return _appIdInfoView;
}

- (UIView *)serverUrlInfoView {
    if (!_serverUrlInfoView) {
        _serverUrlInfoView = [[UIView alloc] init];
        _serverUrlInfoView.backgroundColor = [UIColor lightGrayColor];

        UILabel *title = [[UILabel alloc] init];
        title.text = @"server url";
        [title sizeToFit];
        [_serverUrlInfoView addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_serverUrlInfoView.mas_left).with.offset(10);
            make.centerY.equalTo(_serverUrlInfoView.mas_centerY);
        }];
        
        _serverUrl = [[UITextView alloc] init];
        _serverUrl.editable = YES;
        [_serverUrlInfoView addSubview:_serverUrl];
        [_serverUrl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).with.offset(20);
            make.centerY.equalTo(title.mas_centerY);
            make.top.equalTo(_serverUrlInfoView.mas_top).with.offset(10);
            make.bottom.equalTo(_serverUrlInfoView.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(200);
//            make.height.mas_equalTo(50);
        }];
    }
    
    return _serverUrlInfoView;
}

- (UIView *)isDebugView {
    if (!_isDebugView) {
        _isDebugView = [[UIView alloc] init];
        _isDebugView.backgroundColor = [UIColor lightGrayColor];

        UILabel *title = [[UILabel alloc] init];
        title.text = @"Debug";
        [title sizeToFit];
        [_isDebugView addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_isDebugView.mas_left).with.offset(10);
            make.centerY.equalTo(_isDebugView.mas_centerY);
        }];
        
        _isDebug = [[UISwitch alloc] init];
        if (@available(iOS 14.0, *)) {
//            _isDebug.title = @"Debug";
        } else {
            // Fallback on earlier versions
        }
//        _isDebug.enabled = YES;
        [_isDebugView addSubview:_isDebug];
        [_isDebug mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).with.offset(20);
            make.centerY.equalTo(_isDebugView.mas_centerY);
            make.top.equalTo(_isDebugView.mas_top).with.offset(10);
            make.bottom.equalTo(_isDebugView.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(50);
//            make.height.mas_equalTo(50);
        }];
    }
    
    return _isDebugView;
}

- (UIView *)enablTrack {
    if (!_enablTrack) {
        _enablTrack = [[UIView alloc] init];
        _enablTrack.backgroundColor = [UIColor lightGrayColor];

        UILabel *title = [[UILabel alloc] init];
        title.text = @"Enable track";
        [title sizeToFit];
        [_enablTrack addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_enablTrack.mas_left).with.offset(10);
            make.centerY.equalTo(_enablTrack.mas_centerY);
        }];
        
        _isEnableTrack = [[UISwitch alloc] init];
        if (@available(iOS 14.0, *)) {
//            _isDebug.title = @"Debug";
        } else {
            // Fallback on earlier versions
        }
//        _isDebug.enabled = YES;
        [_enablTrack addSubview:_isEnableTrack];
        [_isEnableTrack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title.mas_right).with.offset(20);
            make.centerY.equalTo(_enablTrack.mas_centerY);
            make.top.equalTo(_enablTrack.mas_top).with.offset(10);
            make.bottom.equalTo(_enablTrack.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(50);
//            make.height.mas_equalTo(50);
        }];
    }
    
    return _enablTrack;
}

@end
