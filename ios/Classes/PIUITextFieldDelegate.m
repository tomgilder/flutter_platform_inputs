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
    NSLog(@"ObjC: textFieldDidBeginEditing");
    [_channel invokeMethod:@"textFieldDidBeginEditing"
                 arguments:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"ObjC: textFieldDidEndEditing");
    [_channel invokeMethod:@"textFieldDidEndEditing"
                 arguments:@{ @"text": textField.text }];
}

@end
