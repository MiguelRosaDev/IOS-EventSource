#import <EventSource/EventSource.h>

@interface MyEventSource : NSObject

@property (nonatomic, strong) EventSource *eventSource;

- (instancetype)initWithURL:(NSString *)url;
- (void)open;
- (void)onMessage;

@end

@implementation MyEventSource

- (instancetype)initWithURL:(NSString *)url {
    self = [super init];
    if (self) {
        self.eventSource = [[EventSource alloc] initWithURL:url];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    return self;
}

- (void)open {
    [self.eventSource onOpen:^{
        NSLog(@"Connection opened");
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)onMessage {
    [self.eventSource onMessage:^(Event *event) {
        if (event.data) {
            NSLog(@"Received message: %@", event.data);
                CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:event.data];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

@end
