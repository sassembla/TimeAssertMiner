//
//  TabViewInterfaceObject.m
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/22.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import "TabViewInterfaceObject.h"
#import "TimeAssertMinerConstSetting.h"

@implementation TabViewInterfaceObject

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}


- (void) setUp {
    messenger = [[MessengerSystem alloc]initWithBodyID:self withSelector:@selector(tabViewCenter:) withName:TABVIEW];
    [messenger inputParent:VIEW];
}

- (void) tabViewCenter:(NSNotification * ) notif {
    
}


- (void) mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];
    [messenger callParent:@"overwriteStartPos",
     [messenger tag:@"event" val:theEvent],
     nil];
}

@end
