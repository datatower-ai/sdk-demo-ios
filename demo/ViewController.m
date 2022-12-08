//
//  ViewController.m
//  demo
//
//  Created by NEO on 2022/12/5.
//

#import "ViewController.h"
#import "DTDBManager.h"
#import "DTEventDBQueue.h"
@interface ViewController ()

@property (nonatomic, strong) DTDBManager *manager;
@property (nonatomic, strong) DTEventDBQueue *dbQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filepath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TDData-event.plist"];
    NSLog(@"%@",filepath);

    self.dbQueue = [[DTEventDBQueue alloc] initWithDBPath:filepath];
    [self.dbQueue addEvent:@"zxc" eventSyn:@"asd" createdAt:[[NSDate date] timeIntervalSince1970] completion:^(BOOL success) {
        NSLog(@"%d",success);
    }];
    
    [self.dbQueue addEvent:@"123" eventSyn:@"456" createdAt:[[NSDate date] timeIntervalSince1970] completion:^(BOOL success) {
        NSLog(@"%d",success);
    }];
    
    [self.dbQueue deleteEventsBySyn:@"asd" completion:^(BOOL success) {
        NSLog(@"%d",success);
    }];
    
    [self.dbQueue queryEventsCount:100 completion:^(NSArray<DTDBEventModel *> * _Nonnull result) {
        NSLog(@"%@",result);
    }];
    
    [self.dbQueue queryEventCountWithCompletion:^(NSUInteger count) {
        NSLog(@"%zd",count);
    }];
}


@end
