@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface DTAnalRepetitiveTrackingThread : NSThread

@property (nonatomic, readonly) NSError * _Nullable errorOut;

- (instancetype)initWithParams:(id _Nullable)ignored
    eventName:(NSString * _Nonnull)eventName
    propertiesAsText:(NSString * _Nullable)propertiesAsText
    repeatTimes:(uint32_t)repeatTimes
    intervalMillis:(uint32_t)intervalMillis;

@end

NS_ASSUME_NONNULL_END
