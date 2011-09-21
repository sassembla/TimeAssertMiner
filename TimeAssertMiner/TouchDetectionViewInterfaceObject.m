//
//  SmallControllView.m
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import "TouchDetectionViewInterfaceObject.h"
#import "TimeAssertMinerConstSetting.h"

#import "TimeMine.h"

@implementation TouchDetectionViewInterfaceObject

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        messenger = [[MessengerSystem alloc] initWithBodyID:self withSelector:@selector(viewReceicver:) withName:VIEW];
        [messenger inputParent:VIEW_CONT];
        [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
    
        startPoint = CGPointMake(-1, -1);
    }
    
    return self;
}

NSString * message;

float size = 12.0;

- (void) viewReceicver:(NSNotification * )notif {
    NSString * exec = [messenger getExecFromNortification:notif];
    NSDictionary * dict = [messenger getTagValueDictionaryFromNotification:notif];
    
    if ([exec isEqualToString:@"drop"]) {
        message = [dict valueForKey:@"message"];
    }
    
    if ([exec isEqualToString:@"overwriteStartPos"]) {
        NSEvent * theEvent = [dict valueForKey:@"event"];
        startPoint = theEvent.locationInWindow;
        startPoint.y+=size/2;
        
        endPoint = theEvent.locationInWindow;
        endPoint.y+=size/2;
        
        NSValue * startPointWrapper = [NSValue valueWithPoint:startPoint];
        NSValue * endPointWrapper = [NSValue valueWithPoint:endPoint];
        
        [messenger callParent:@"lineStarted", 
         [messenger tag:@"startPoint" val:startPointWrapper],
         [messenger tag:@"endPoint" val:endPointWrapper],
         nil];
        [self setNeedsDisplay:YES];

        
//       [self mouseDown:[dict valueForKey:@"event"]];
    }
    
}


- (void)drawRect:(NSRect)dirtyRect {
    if (startPoint.x < 0) {
        return;
    }
    if (startPoint.y < 0) {
        return;
    }
    
    //ライン:画面外まで出れない
    NSBezierPath * path = [NSBezierPath bezierPath];
    [path setLineWidth: 4];
    [path  moveToPoint: startPoint];	
    [path lineToPoint:endPoint];
    
    NSColor *lineBlue = [NSColor colorWithCalibratedRed:0.137f green:0.509f blue:0.792f alpha:1.0f];
    
    [lineBlue set]; 
    [path stroke];
    
    
    //丸の元を作る(陰の為に必要)
    NSRect startOval = { startPoint.x-size/2, startPoint.y-size/2, size, size };
    NSBezierPath * startPointBall = [NSBezierPath bezierPathWithOvalInRect:startOval];
    [startPointBall setLineWidth:2.38];
    
    
    NSShadow *dropShadow = [[[NSShadow alloc] init] autorelease];
    [dropShadow setShadowColor:[NSColor blackColor]];
    [dropShadow setShadowBlurRadius:4];
    [dropShadow setShadowOffset:NSMakeSize(2,-2)];
    
    [NSGraphicsContext saveGraphicsState];
    [dropShadow set];
    
    NSColor *ballBlue = [NSColor colorWithCalibratedRed:0 green:0.439f blue:0.77f alpha:1.0f];
    
     [ballBlue set]; 
    [startPointBall fill];//中身と陰を描画
    [NSGraphicsContext restoreGraphicsState];
    
    //丸を表示
    NSColor * white = [NSColor whiteColor];
    [white set];[startPointBall stroke];
}

- (void)mouseDown:(NSEvent *)theEvent {
    
    startPoint = theEvent.locationInWindow;
    startPoint.y+=size/2;
    
    endPoint = theEvent.locationInWindow;
    endPoint.y+=size/2;
    
    NSValue * startPointWrapper = [NSValue valueWithPoint:startPoint];
    NSValue * endPointWrapper = [NSValue valueWithPoint:endPoint];
    
    [messenger callParent:@"lineStarted", 
     [messenger tag:@"startPoint" val:startPointWrapper],
     [messenger tag:@"endPoint" val:endPointWrapper],
     nil];
    [self setNeedsDisplay:YES];
}
- (void) mouseDragged:(NSEvent *)theEvent{
    
    endPoint = theEvent.locationInWindow;
    endPoint.y+=size/2;
    
    NSValue * startPointWrapper = [NSValue valueWithPoint:startPoint];
    NSValue * endPointWrapper = [NSValue valueWithPoint:endPoint];
   
    
    [messenger callParent:@"lineDragged", 
     [messenger tag:@"startPoint" val:startPointWrapper],
     [messenger tag:@"endPoint" val:endPointWrapper],
     nil];

    [self setNeedsDisplay:YES];
}
- (void)mouseUp:(NSEvent *)theEvent {
    if (0 < theEvent.locationInWindow.x && theEvent.locationInWindow.x < self.frame.size.width) {
        if(0 < theEvent.locationInWindow.y && theEvent.locationInWindow.y < self.frame.size.height) {
            [messenger callParent:@"uped",
             nil];
        }
    }
    
    NSValue * startPointWrapper = [NSValue valueWithPoint:startPoint];
    
    [messenger callParent:@"lineDropped",
     [messenger tag:@"startPoint" val:startPointWrapper],
     nil];
    
    startPoint = CGPointMake(-1, -1);
    [self setNeedsDisplay:YES];
    
    [self dragFile:message
          fromRect:[self frame]
         slideBack:YES
             event:theEvent
     ];
}


- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSLog(@"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    
//    NSPasteboard *pboard = [sender draggingPasteboard];
//    
//    if ([[pboard types] containsObject:NSFilenamesPboardType]) {
//        
//        NSArray *paths = [pboard propertyListForType:NSFilenamesPboardType];
//        for (NSString *path in paths) {
//            NSError *error = nil;
//            NSString *utiType = [[NSWorkspace sharedWorkspace]
//                                 typeOfFile:path error:&error];
//            if (![[NSWorkspace sharedWorkspace] 
//                  type:utiType conformsToType:(id)kUTTypeFolder]) {
//                
//                //[self setHighlighted:NO];
//                return NSDragOperationNone;
//            }
//        }
//    }
    return NSDragOperationEvery;
}




@end
