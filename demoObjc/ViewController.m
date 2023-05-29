//
//  ViewController.m
//  demoObjc
//
//  Created by Lilin on 2023/5/29.
//

#import "ViewController.h"
#import <DataTowerAICore/DTAnalytics.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    let properties1 = ["product_name": "商品名"] as [String: Any]
//    let properties2 = ["#product_name": "商品名"] as [String: Any]
//    DTAnalytics.trackEventName("track_sample", properties: properties1);
//    DTAnalytics.trackEventName("track_sample_invalid", properties: properties2);
    
    NSDictionary *properties1 = @{
        @"product_name":@"商品名",
    };
    
    NSDictionary *properties2 = @{
        @"#product_name":@"商品名",
    };
    
    [DTAnalytics trackEventName:@"track_sample" properties:properties1];
    [DTAnalytics trackEventName:@"track_sample_invalid" properties:properties2];
}


@end
