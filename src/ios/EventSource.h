#import <Cordova/CDV.h>


@interface EventSource : CDVPlugin {
}

// The hooks for our plugin commands
- (void)onOpen:(CDVInvokedUrlCommand *)command;
- (void)onMessage:(CDVInvokedUrlCommand *)command;

@end
