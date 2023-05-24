#import <EventSource/EventSource.h>

@interface MyEventSource : NSObject

@property (nonatomic, strong) EventSource *eventSource;

- (instancetype)initWithURL:(NSString *)url;
- (void)open;
- (void)onMessage;

@end

@implementation MyEventSource

- (void)initWithURL:(CDVInvokedUrlCommand *)command {
    NSString* url = [command.arguments objectAtIndex:0] != (NSString *)[NSNull null] ? [command.arguments objectAtIndex:0] : nil;
    self = [super init];
    if (self) {
        self.eventSource = [[EventSource alloc] initWithURL:url];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    return self;
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
