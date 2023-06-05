#import "DTAnalRepetitiveTrackingThread.h"

#import "DTAnalytics.h"
#import <OSLog/OSLog.h>

@interface DTAnalRepetitiveTrackingThread () {
    NSString * _Nonnull _eventName;
    NSString * _Nullable _propertiesAsText;
    NSDictionary * _Nullable _propertiesAsDict;
    uint32_t _repeatTimes;
    uint32_t _intervalMillis;
    uint32_t _currentTimeOfRepeat;
}
@end

@implementation DTAnalRepetitiveTrackingThread

- (instancetype)init {
    return nil;
}

- (instancetype)initWithParams:(id)ignored
    eventName:(NSString * _Nonnull)eventName
    propertiesAsText:(NSString * _Nullable)propertiesAsText
    repeatTimes:(uint32_t)repeatTimes
    intervalMillis:(uint32_t)intervalMillis {

    self = [super init];
    if (!self) return self;

    if (eventName == nil) return nil;
    _eventName = eventName;
    _propertiesAsText = propertiesAsText;
    _repeatTimes = repeatTimes;
    _intervalMillis = intervalMillis;
    _currentTimeOfRepeat = 0;
    _errorOut = nil;

    return self;
}

- (void)main {
    NSError * _Nullable errOut = nil;
    __auto_type const propertiesAsUtf8NSData = [_propertiesAsText dataUsingEncoding:NSUTF8StringEncoding];
    id const properties = [NSJSONSerialization JSONObjectWithData:propertiesAsUtf8NSData options:0 error:&errOut];
    if (errOut != nil) {
        _errorOut = errOut;
        return;
    }
    if (![properties isKindOfClass:NSDictionary.class]) {
        _errorOut = [NSError errorWithDomain:@"properties isn't a json object." code:-1 userInfo:nil];
        return;
    }
    _propertiesAsDict = properties;

    __auto_type const runLoop = [NSRunLoop currentRunLoop];
    os_log(OS_LOG_DEFAULT, "before [runLoop performSelector:withObject:]");
    [self performSelector:@selector(invokeTrackEvent) withObject:self];
    os_log(OS_LOG_DEFAULT, "before [runLoop run]");
    [runLoop run];
}

- (void)invokeTrackEvent {
    os_log(OS_LOG_DEFAULT, "in [DTARTT invokeTrackEvent]");
    __auto_type const runLoop = [NSRunLoop currentRunLoop];
    if (_currentTimeOfRepeat >= _repeatTimes) {
        CFRunLoopStop([runLoop getCFRunLoop]);
        return;
    }
    _currentTimeOfRepeat++;

    if (_propertiesAsDict != nil) {
        [DTAnalytics trackEventName:_eventName properties:_propertiesAsDict];
    } else {
        [DTAnalytics trackEventName:_eventName];
    }
    [self performSelector:@selector(invokeTrackEvent) withObject:self afterDelay:_intervalMillis * 0.001];
}

@end

@interface DTAnalTrackEventRepeatedOperation : NSOperation {
}

@end
