//
//  FullApiViewController.m
//  demoObjc
//
//  Created by Lilin on 2023/6/15.
//

#import "FullApiViewController.h"
#import <Masonry/Masonry.h>
#import <DataTowerAICore/DTAnalytics.h>
#import <DataTowerAICore/DTAdReport.h>
#import <DataTowerAICore/DTAnalyticsUtils.h>
#import <DataTowerAICore/DTIAPReport.h>
#import <DataTowerAICore/DTIASReport.h>
#import <objc/runtime.h>

const CGFloat startX = 25;
const NSString *star = @"*********************";
#define controlWidth  ([UIScreen mainScreen].bounds.size.width - leftX * 2)
#define alignTop(topView, nextView, height)  nextView.frame = CGRectMake(leftX, CGRectGetMinY(topView.frame) + CGRectGetHeight(topView.frame) + 10, controlWidth, height);

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface FullApiViewController ()

@property (nonatomic) UIButton *closeBtn;
@property (nonatomic) UITextView *apiTextview;
@property (nonatomic) UIScrollView *contentView;
@property (nonatomic) UIButton *copyBtn;

@end

@implementation FullApiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.apiTextview];
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.copyBtn];

    [self.copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.closeBtn.mas_left).with.offset(-20);
        make.centerY.equalTo(self.closeBtn.mas_centerY);
        make.height.mas_equalTo(30);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(self.copyBtn.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
    }];
    
    [self loadApi];
}

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)copyApi {
    NSString *fullApi = self.apiTextview.text;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = fullApi;
}

- (void)loadApi {
    NSString *formatStr;
    NSMutableArray *fullApiList = [NSMutableArray arrayWithArray:[self fullApiList]];
    
    formatStr = [NSString stringWithFormat:@"%@", star];
    NSArray *ary = [self filterApi:@"track" fromList:fullApiList];
    
    formatStr = [NSString stringWithFormat:@"%@\nSumary: count: %ld api",formatStr, ary.count];
    formatStr = [NSString stringWithFormat:@"%@\n%@", formatStr, star];

    for (NSString *api in ary) {
        formatStr = [NSString stringWithFormat:@"%@\n%@\n", formatStr, api];
    }
    
    formatStr = [NSString stringWithFormat:@"%@\n%@", formatStr, star];
    ary = [self filterApi:@"user" fromList:fullApiList];
    
    formatStr = [NSString stringWithFormat:@"%@\nSumary: count: %ld api",formatStr, ary.count];
    formatStr = [NSString stringWithFormat:@"%@\n%@", formatStr, star];
    
    for (NSString *api in ary) {
        formatStr = [NSString stringWithFormat:@"%@\n%@\n", formatStr, api];
    }
    
    formatStr = [NSString stringWithFormat:@"%@\n%@", formatStr, star];
    ary = [self filterApi:@"set" fromList:fullApiList];
    formatStr = [NSString stringWithFormat:@"%@\nSumary: count: %ld api",formatStr, ary.count];
    formatStr = [NSString stringWithFormat:@"%@\n%@", formatStr, star];
    for (NSString *api in ary) {
        formatStr = [NSString stringWithFormat:@"%@\n%@\n", formatStr, api];
    }
    
    formatStr = [NSString stringWithFormat:@"%@\n%@", formatStr, star];
    ary = [self filterApi:@"get" fromList:fullApiList];
    formatStr = [NSString stringWithFormat:@"%@\nSumary: count: %ld api",formatStr, ary.count];
    formatStr = [NSString stringWithFormat:@"%@\n%@", formatStr, star];
    for (NSString *api in ary) {
        formatStr = [NSString stringWithFormat:@"%@\n%@\n", formatStr, api];
    }
    
    formatStr = [NSString stringWithFormat:@"%@\n%@", formatStr, star];
    ary = [self filterApi:@"report" fromList:fullApiList];
    formatStr = [NSString stringWithFormat:@"%@\nSumary: count: %ld api",formatStr, ary.count];
    formatStr = [NSString stringWithFormat:@"%@\n%@", formatStr, star];
    for (NSString *api in ary) {
        formatStr = [NSString stringWithFormat:@"%@\n%@\n", formatStr, api];
    }
    
    formatStr = [NSString stringWithFormat:@"%@\n%@", formatStr, star];
    ary = fullApiList;
    for (NSString *api in ary) {
        formatStr = [NSString stringWithFormat:@"%@\n%@\n", formatStr, api];
    }
    
    self.apiTextview.text = formatStr;
    [self.apiTextview sizeToFit];
    self.contentView.contentSize = self.apiTextview.bounds.size;
}

- (NSArray<NSString *> *)filterApi:(NSString *)apiPrefix fromList:(NSMutableArray *)sourceAry {
    NSMutableArray *ret = [NSMutableArray array];
    NSInteger outCount = sourceAry.count;
    for (uint i = 0; i < outCount; ++i) {
        NSString *funcName = sourceAry[i];
        if ([funcName hasPrefix:apiPrefix]) {
            [ret addObject:funcName];
        }
    }
    
    for (NSString *api in ret) {
        [sourceAry removeObject:api];
    }
    return ret;
}

- (NSArray<NSString *> *)fullApiList {
    NSMutableArray *ret = [NSMutableArray array];
    unsigned int outCount;
    Method *methodList = class_copyMethodList(object_getClass([DTAnalytics class]), &outCount);
    for (uint i = 0; i < outCount; ++i) {
        SEL name = method_getName(methodList[i]);
        NSString *funcName = NSStringFromSelector(name);
        [ret addObject:funcName];
    }
    
    methodList = class_copyMethodList(object_getClass([DTAdReport class]), &outCount);
    for (uint i = 0; i < outCount; ++i) {
        SEL name = method_getName(methodList[i]);
        NSString *funcName = NSStringFromSelector(name);
        [ret addObject:funcName];
    }
    
    methodList = class_copyMethodList(object_getClass([DTAnalyticsUtils class]), &outCount);
    for (uint i = 0; i < outCount; ++i) {
        SEL name = method_getName(methodList[i]);
        NSString *funcName = NSStringFromSelector(name);
        [ret addObject:funcName];
    }
    
    methodList = class_copyMethodList(object_getClass([DTIAPReport class]), &outCount);
    for (uint i = 0; i < outCount; ++i) {
        SEL name = method_getName(methodList[i]);
        NSString *funcName = NSStringFromSelector(name);
        [ret addObject:funcName];
    }
    
    methodList = class_copyMethodList(object_getClass([DTIASReport class]), &outCount);
    for (uint i = 0; i < outCount; ++i) {
        SEL name = method_getName(methodList[i]);
        NSString *funcName = NSStringFromSelector(name);
        [ret addObject:funcName];
    }
    
    return ret;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"Res/closeBtn"] forState:UIControlStateNormal];
        _closeBtn.frame = CGRectMake(screenWidth - startX - 30, startX, 30, 30);
        [_closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UITextView *)apiTextview {
    if (!_apiTextview) {
        _apiTextview = [[UITextView alloc] init];
        _apiTextview.editable = NO;
    }
    return _apiTextview;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
    }
    return _contentView;
}

- (UIButton *)copyBtn {
    if (!_copyBtn) {
        _copyBtn = [[UIButton alloc] init];
        _copyBtn.backgroundColor = [UIColor blueColor];
        _copyBtn.layer.cornerRadius = 5;
        [_copyBtn setTitle:@"Copy All" forState:UIControlStateNormal];
        [_copyBtn addTarget:self action:@selector(copyApi) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copyBtn;
}

@end
