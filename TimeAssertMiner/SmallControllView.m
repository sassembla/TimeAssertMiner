//
//  SmallControllView.m
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import "SmallControllView.h"
#import "TimeAssertMinerConstSetting.h"

@implementation SmallControllView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        messenger = [[MessengerSystem alloc] initWithBodyID:self withSelector:@selector(viewReceicver:) withName:VIEW];
        [messenger inputParent:VIEW_CONT];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"down");
}
- (void)mouseMoved:(NSEvent *)theEvent {
    NSLog(@"move    %@", theEvent);
}
- (void)mouseUp:(NSEvent *)theEvent {
    NSLog(@"up");
    [messenger callParent:@"uped",nil];
}



@end
