//
//  ViewController.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "DTDemoViewController.h"
#import <DataTowerAICore/DTAnalytics.h>
#import "Datasource.h"
#import "CellViewModel.h"
#import "CustomCell.h"
#import <QMUIKit/QMUITips.h>

@interface DTDemoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) Datasource *data;

@end

@implementation DTDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSDictionary *properties1 = @{
//        @"product_name":@"商品名",
//    };
//    
//    NSDictionary *properties2 = @{
//        @"#product_name":@"商品名",
//    };
//    
//    [DTAnalytics trackEventName:@"track_sample" properties:properties1];
//    [DTAnalytics trackEventName:@"track_sample_invalid" properties:properties2];
//    
    [self.view addSubview:self.tableView];
    [self.data class];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *ret = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomCell class])];
    if(!ret) {
        ret = [[CustomCell alloc] init];
        [tableView registerClass:[CustomCell class] forCellReuseIdentifier:NSStringFromClass([CustomCell class])];
    }
    
//    ret.backgroundColor = [UIColor yellowColor];
    
    CellViewModel *viweModel = self.data.items[indexPath.row];
    [ret setModel:viweModel];
    return ret;
}

#pragma <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CustomCell cellHeihgt];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *viweModel = self.data.items[indexPath.row];
    
    if(viweModel.tapAction) {
        viweModel.tapAction();
    }
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}

#pragma Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
//        _tableView.backgroundColor = [UIColor yellowColor];
        _tableView.frame = self.view.bounds;
    }
    
    return _tableView;;
}

- (Datasource *)data {
    if(!_data) {
        _data = [[Datasource alloc] init];
        _data.appId = self.appId;
        _data.serverUrl = self.serverUrl;
        _data.isDebug = self.isDebug;
        __weak typeof(self) weakSelf = self;
        _data.action = ^{
            [weakSelf.tableView reloadData];
        };
        [_data prepareData];
    }
    
    return _data;
}


@end
