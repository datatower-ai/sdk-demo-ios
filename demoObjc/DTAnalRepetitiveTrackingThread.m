#import "DTAnalRepetitiveTrackingThread.h"

#import <OSLog/OSLog.h>
#import <QMUIKit/QMUITips.h>
#import <DataTowerAICore/DTAnalytics.h>

@interface DTAnalRepetitiveTrackingThread ()

@property (nonatomic) uint32_t intervalMillis;
@property (nonatomic) uint32_t repeatTimes;
@property (nonatomic) NSString *eventName;
@property (nonatomic) NSString *propertiesAsText;
@property (nonatomic) NSDictionary *propertiesAsDict;
@property (nonatomic) uint32_t currentTimeOfRepeat;

@end

@implementation DTAnalRepetitiveTrackingThread

static DTAnalRepetitiveTrackingThread *_instance = nil;

+ (DTAnalRepetitiveTrackingThread *)shareInstance {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        _instance = [[DTAnalRepetitiveTrackingThread alloc] init];
    });
    return _instance;
}

- (void)start:(NSString *)eventName propertiesAsText:(NSString * _Nullable)propertiesAsText repeatTimes:(uint32_t)repeatTimes intervalMillis:(uint32_t)intervalMillis; {
    
    if (eventName == nil || eventName.length == 0)  {
        [QMUITips showInfo:@"非法的事件名" inView:[UIApplication sharedApplication].keyWindow].userInteractionEnabled = NO;
        return;
    }
    
    NSString *jsonStr = propertiesAsText;
    if (jsonStr.length != 0) {
        
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\"" withString:@"\""];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"”" withString:@"\""];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"“" withString:@"\""];
                
        NSError *jsonError;
        NSData *objectData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:objectData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
        if (jsonError) {
            [QMUITips showInfo:@"Json字符串格式错我" inView:[UIApplication sharedApplication].keyWindow].userInteractionEnabled = NO;
            return;
        }
    }
    
    _eventName = eventName;
    _propertiesAsText = propertiesAsText;
    _repeatTimes = repeatTimes;
    _intervalMillis = intervalMillis;
    _currentTimeOfRepeat = 0;
    _errorOut = nil;
    
    [self runTaskLoop];
}

- (void)runTaskLoop {
    if (!self.isStop && self.repeatTimes > self.currentTimeOfRepeat) {
        [self doEventTrack];
        self.currentTimeOfRepeat++;
        
        [QMUITips showInfo:[NSString stringWithFormat:@"运行%d/%d", self.currentTimeOfRepeat, self.repeatTimes] inView:[UIApplication sharedApplication].keyWindow].userInteractionEnabled = NO;
        
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, self.intervalMillis * NSEC_PER_SEC / 1000), dispatch_get_main_queue(), ^{
            [weakSelf runTaskLoop];
        });
    }
}

- (void)doEventTrack {
    if (self.propertiesAsDict != nil) {
        [DTAnalytics trackEventName:self.eventName properties:self.propertiesAsDict];
    } else {
        [DTAnalytics trackEventName:self.eventName];
    }
}

@end
