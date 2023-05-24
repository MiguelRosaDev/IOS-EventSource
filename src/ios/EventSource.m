#import <EventSource/EventSource.h>
#import <Cordova/CDVPlugin.h>

@interface MyEventSource : CDVPlugin

@property (nonatomic, strong) EventSource *eventSource;

- (void)initialize:(CDVInvokedUrlCommand *)command;
- (void)open:(CDVInvokedUrlCommand *)command;
- (void)onMessage:(CDVInvokedUrlCommand *)command;

@end

@implementation MyEventSource

- (void)initialize:(CDVInvokedUrlCommand *)command {
    NSString *url = [command.arguments objectAtIndex:0] != (NSString *)[NSNull null] ? [command.arguments objectAtIndex:0] : nil;
    self.eventSource = [[EventSource alloc] initWithURL:[NSURL URLWithString:url]];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)open:(CDVInvokedUrlCommand *)command {
    [self.eventSource onOpen:^{
        NSLog(@"Connection opened");
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)onMessage:(CDVInvokedUrlCommand *)command {
    [self.eventSource onMessage:^(Event *event) {
        if (event.data) {
            NSLog(@"Received message: %@", event.data);
            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:event.data];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

@end
