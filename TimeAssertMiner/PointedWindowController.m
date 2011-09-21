//
//  PointedWindowController.m
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/21.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import "PointedWindowController.h"
#import "TimeAssertMinerConstSetting.h"

#import "TimeMine.h"

@implementation PointedWindowController


- (id)initWithID:(int)idNum
{
    
    NSWindow * pointWindow = [[NSWindow alloc] initWithContentRect:CGRectMake(-1000/2, -1000/2, 1000, 1000) styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:YES];
    
    self = [super initWithWindow:pointWindow];
    
    if (self) {
        m_idNum = [NSNumber numberWithInt:idNum];
        messenger = [[MessengerSystem alloc]initWithBodyID:self withSelector:@selector(windowCenter:) withName:POINTEDWINDW_CONT];
        [messenger inputParent:MASTER_DELEGATE];
        
        
        [self.window setOpaque:NO];
        
        [self.window setBackgroundColor:[NSColor clearColor]];
                
        pointView = [[PointedView alloc]initWithFrame:pointWindow.frame];
        [self.window setContentView:pointView];
        
    }
    
    return self;
}

- (void) windowCenter:(NSNotification * )notif {
    NSString * exec = [messenger getExecFromNortification:notif];
    NSDictionary * dict = [messenger getTagValueDictionaryFromNotification:notif];
        
    if ([exec isEqualToString:@"move"]) {
        if (![self.window isVisible]) {
            [self.window makeKeyAndOrderFront:self];
        }
        
        NSPoint endPoint = [[dict valueForKey:@"endPoint"] pointValue];
        endPoint.x-=self.window.frame.size.width/2.0;
        endPoint.y-=self.window.frame.size.height/2.0;
        [self.window setFrameOrigin:endPoint];
    
        
        NSPoint startPoint = [[dict valueForKey:@"startPoint"] pointValue];
        startPoint.x -= self.window.frame.origin.x;
        startPoint.y -= self.window.frame.origin.y;
        [pointView updatePoints:startPoint];
    }
    
    if ([exec isEqualToString:@"remove"]) {        
        [self.window close];
        
    }
}


- (void)windowDidLoad
{
    [super windowDidLoad];
    
}

@end
