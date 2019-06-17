#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface PIUITextFieldDelegate : NSObject <UITextFieldDelegate>

- (instancetype)initWithChannel:(FlutterMethodChannel*)channel;

@end

NS_ASSUME_NONNULL_END
