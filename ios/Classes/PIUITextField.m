#import "PIUITextField.h"
#import "PIUITextFieldDelegate.h"

@implementation PIUITextField {
    UITextField* _textField;
    int64_t _viewId;
    FlutterMethodChannel* _channel;
    PIUITextFieldDelegate* _delegate;
}


- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    
    if ([super init]) {
        NSString* channelName = [NSString stringWithFormat:@"dev.gilder.tom/uitextfield_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        
        _viewId = viewId;
        
        _textField = [[UITextField alloc] initWithFrame:frame];
        _textField.text = args[@"text"];
        _textField.placeholder = args[@"placeholder"];
        _textField.keyboardType = [self keyboardTypeFromString:args[@"textContentType"]];
        _textField.secureTextEntry = [args[@"obsecureText"] boolValue];
        
        if (@available(iOS 10.0, *)) {
            _textField.textContentType = [self textContentTypeFromString:args[@"textContentType"]];
        }
        
        _delegate = [[PIUITextFieldDelegate alloc] initWithChannel:_channel];
        _textField.delegate = _delegate;
        
        [_textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
        
        __weak __typeof__(self) weakSelf = self;
        [_channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
            [weakSelf onMethodCall:call result:result];
        }];
    }
    return self;
}

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([[call method] isEqualToString:@"focus"]) {
        [self onFocus:call result:result];
    } else if ([[call method] isEqualToString:@"setText"]) {
        [self onSetText:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)onFocus:(FlutterMethodCall*)call result:(FlutterResult)result {
    [_textField becomeFirstResponder];
    result(nil);
}

- (void)onSetText:(FlutterMethodCall*)call result:(FlutterResult)result {
    _textField.text = call.arguments[@"text"];
    result(nil);
}

- (UIView*)view {
    return _textField;
}

- (void)textFieldDidChange:(UITextField *)textField {
    [_channel invokeMethod:@"onChanged"
                 arguments:@{ @"text" : textField.text }];
}

- (UIKeyboardType)keyboardTypeFromString:(NSString*)keyboardType {
    if (!keyboardType || [keyboardType isKindOfClass:[NSNull class]]) {
        return UIKeyboardTypeDefault;
    }
    
    if ([keyboardType isEqualToString:@"KeyboardType.asciiCapable"]) {
        return UIKeyboardTypeASCIICapable;
    }
    else if ([keyboardType isEqualToString:@"KeyboardType.numbersAndPunctuation"]) {
        return UIKeyboardTypeNumbersAndPunctuation;
    }
    else if ([keyboardType isEqualToString:@"KeyboardType.url"]) {
        return UIKeyboardTypeURL;
    }
    else if ([keyboardType isEqualToString:@"KeyboardType.numberPad"]) {
        return UIKeyboardTypeNumberPad;
    }
    else if ([keyboardType isEqualToString:@"KeyboardType.phonePad"]) {
        return UIKeyboardTypePhonePad;
    }
    else if ([keyboardType isEqualToString:@"KeyboardType.namePhonePad"]) {
        return UIKeyboardTypeNamePhonePad;
    }
    else if ([keyboardType isEqualToString:@"KeyboardType.emailAddress"]) {
        return UIKeyboardTypeEmailAddress;
    }
    else if ([keyboardType isEqualToString:@"KeyboardType.decimalPad"]) {
        return UIKeyboardTypeDecimalPad;
    }
    else if ([keyboardType isEqualToString:@"KeyboardType.twitter"]) {
        return UIKeyboardTypeTwitter;
    }
    else if ([keyboardType isEqualToString:@"KeyboardType.webSearch"]) {
        return UIKeyboardTypeWebSearch;
    }
    else if ([keyboardType isEqualToString:@"KeyboardType.asciiCapableNumberPad"]) {
        if (@available(iOS 10.0, *)) {
            return UIKeyboardTypeASCIICapableNumberPad;
        } else {
            return UIKeyboardTypeNumberPad;
        }
    }
    
    return UIKeyboardTypeDefault;
}

- (UITextContentType)textContentTypeFromString:(NSString*)contentType {
    if (!contentType || [contentType isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    if (@available(iOS 10.0, *)) {
        
        if ([contentType isEqualToString:@"TextContentType.username"]) {
            if (@available(iOS 11.0, *)) {
                return UITextContentTypeUsername;
            } else {
                return nil;
            }
        }
        
        if ([contentType isEqualToString:@"TextContentType.password"]) {
            if (@available(iOS 11.0, *)) {
                return UITextContentTypePassword;
            } else {
                return nil;
            }
        }
        
        if ([contentType isEqualToString:@"TextContentType.newPassword"]) {
            if (@available(iOS 12.0, *)) {
                return UITextContentTypeNewPassword;
            } else if (@available(iOS 11.0, *)) {
                return UITextContentTypePassword;
            } else {
                return nil;
            }
        }
        
        if ([contentType isEqualToString:@"TextContentType.oneTimeCode"]) {
            if (@available(iOS 12.0, *)) {
                return UITextContentTypeOneTimeCode;
            } else {
                return nil;
            }
        }
        
        NSDictionary *dict =
        @{
          @"TextContentType.name":                  UITextContentTypeName,
          @"TextContentType.namePrefix":            UITextContentTypeNamePrefix,
          @"TextContentType.givenName":             UITextContentTypeGivenName,
          @"TextContentType.middleName":            UITextContentTypeMiddleName,
          @"TextContentType.familyName":            UITextContentTypeFamilyName,
          @"TextContentType.nameSuffix":            UITextContentTypeNameSuffix,
          @"TextContentType.nickname":              UITextContentTypeNickname,
          @"TextContentType.jobTitle":              UITextContentTypeJobTitle,
          @"TextContentType.organizationName":      UITextContentTypeOrganizationName,
          @"TextContentType.location":              UITextContentTypeLocation,
          @"TextContentType.fullStreetAddress":     UITextContentTypeFullStreetAddress,
          @"TextContentType.streetAddressLine1":    UITextContentTypeStreetAddressLine1,
          @"TextContentType.streetAddressLine2":    UITextContentTypeStreetAddressLine2,
          @"TextContentType.city":                  UITextContentTypeAddressCity,
          @"TextContentType.addressState":          UITextContentTypeAddressState,
          @"TextContentType.addressCityAndState":   UITextContentTypeAddressCityAndState,
          @"TextContentType.sublocality":           UITextContentTypeSublocality,
          @"TextContentType.countryName":           UITextContentTypeCountryName,
          @"TextContentType.postalCode":            UITextContentTypePostalCode,
          @"TextContentType.telephoneNumber":       UITextContentTypeTelephoneNumber,
          @"TextContentType.emailAddress":          UITextContentTypeEmailAddress,
          @"TextContentType.url":                   UITextContentTypeURL,
          @"TextContentType.creditCardNumber":      UITextContentTypeCreditCardNumber
          };
        
        return dict[contentType];
    } else {
        return nil;
    }
}

@end
