@interface MySingleton : NSObject {
    NSInteger profile;
    UIViewController *currentController;
}
@property (nonatomic) NSInteger profile;
@property (nonatomic, retain) UIViewController *currentController;

+(MySingleton *)sharedMySingleton;

@end
