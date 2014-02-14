#import "MySingleton.h"

@implementation MySingleton

@synthesize profile;
@synthesize currentController;

static MySingleton * sharedMySingleton = NULL;
+(MySingleton *)sharedMySingleton {
    if (!sharedMySingleton || sharedMySingleton == NULL) {
		sharedMySingleton = [MySingleton new];
	}
	return sharedMySingleton;
}

- (void)dealloc {
    self.profile = nil;
    self.currentController = nil;
    //[super dealloc];
}

@end