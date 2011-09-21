//
//  PointedWindowController.h
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/21.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MessengerSystem.h"
#import "PointedView.h"

@interface PointedWindowController : NSWindowController
{
    MessengerSystem * messenger;
    PointedView * pointView;
    
    NSNumber * m_idNum;
    NSWindow * lineWindow;
}
- (id)initWithID:(int)idNum;
@end
