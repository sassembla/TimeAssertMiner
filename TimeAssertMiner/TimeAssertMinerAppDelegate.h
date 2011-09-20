//
//  TimeAssertMinerAppDelegate.h
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MessengerSystem.h"



@interface TimeAssertMinerAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    
    MessengerSystem * messenger;
    
}
@property (assign) IBOutlet NSWindow *window;

@end
