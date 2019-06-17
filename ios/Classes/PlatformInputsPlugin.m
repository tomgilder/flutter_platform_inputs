#import "PlatformInputsPlugin.h"
#import "PIUITextFieldFactory.h"

@implementation PlatformInputsPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    PIUITextFieldFactory* textFieldFactory =
        [[PIUITextFieldFactory alloc] initWithMessenger:registrar.messenger];
    
    [registrar registerViewFactory:textFieldFactory
                            withId:@"dev.gilder.tom/uitextfield"];
}

@end
