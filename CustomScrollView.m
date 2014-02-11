#import "CustomScrollView.h"

@implementation CustomScrollView

@synthesize subViewRect;

- (id)initWithFrame:(CGRect)frame
{
    //return [super initWithFrame:frame];
    if (self = [super initWithFrame:frame]) {
        self.delaysContentTouches = NO;
    }
    return self;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.dragging) {
        //self.scrollEnabled=NO;
        [self.nextResponder touchesBegan:touches withEvent:event];
        
    }
    else{
        [super touchesBegan: touches withEvent: event];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.dragging) {
        //self.scrollEnabled=NO;
        [self.nextResponder touchesMoved:touches withEvent:event];
        
    }
    else{
        [super touchesMoved: touches withEvent: event];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (!self.dragging)
        [self.nextResponder touchesEnded: touches withEvent:event];
    else
        [super touchesEnded: touches withEvent: event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

@end