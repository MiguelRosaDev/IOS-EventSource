#import <Cordova/CDV.h>


@interface MyEventSource : CDVPlugin {
}

// The hooks for our plugin commands
- (void)initialize:(CDVInvokedUrlCommand *)command;
- (void)open:(CDVInvokedUrlCommand *)command;
- (void)onMessage:(CDVInvokedUrlCommand *)command;

@end
