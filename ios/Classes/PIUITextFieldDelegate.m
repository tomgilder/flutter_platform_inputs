#import "PIUITextFieldDelegate.h"

@implementation PIUITextFieldDelegate {
    FlutterMethodChannel* _channel;
}

- (instancetype)initWithChannel:(FlutterMethodChannel*)channel {
    self = [super init];
    if (self) {
        _channel = channel;
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [_channel invokeMethod:@"textFieldDidBeginEditing"
                 arguments:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [_channel invokeMethod:@"textFieldDidEndEditing"
                 arguments:@{ @"text": textField.text }];
}

@end
