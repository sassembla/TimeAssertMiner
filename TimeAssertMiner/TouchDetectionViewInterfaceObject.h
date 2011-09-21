//
//  TouchDetectionViewInterfaceObject.h
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MessengerSystem.h"
@interface TouchDetectionViewInterfaceObject : NSView
{
    MessengerSystem * messenger;
    
    
    NSPoint startPoint;
    NSPoint endPoint;
}
@end
