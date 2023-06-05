@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface DTAnalRepetitiveTrackingThread : NSThread

@property (nonatomic, readonly) NSError * _Nullable errorOut;
@property (nonatomic, getter=isStop) BOOL stop;

+ (DTAnalRepetitiveTrackingThread *)shareInstance;

- (void)start:(NSString *)eventName propertiesAsText:(NSString * _Nullable)propertiesAsText repeatTimes:(uint32_t)repeatTimes intervalMillis:(uint32_t)intervalMillis;

@end

NS_ASSUME_NONNULL_END
