//
//  TimeAssertMinerAppDelegate.m
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import "TimeAssertMinerAppDelegate.h"
#import "SmallControllViewController.h"
#import "PointedWindowController.h"


#import "TimeAssertMinerConstSetting.h"

#import "TimeMine.h"

@implementation TimeAssertMinerAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    messenger = [[MessengerSystem alloc]initWithBodyID:self withSelector:@selector(receiveCenter:) withName:MASTER_DELEGATE]; 

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hearing:) name:nil object:nil];
    
    SmallControllViewController * tViewCont = [[SmallControllViewController alloc]init];
    [window setContentView:tViewCont.view];
    
    
    for (int i = 0; i < 1; i++) {
        [[PointedWindowController alloc]initWithID:i];
    }
    [TimeMine setTimeMineLocalizedFormat:@"11/09/19 9:04:14" withLimitSec:1000000 withComment:@"grepについて調べる。インターフェースとして、用件はまとめてあるので、どうやるか。　かなり後回し。用件が多い。"];
    
    
    [TimeMine setTimeMineLocalizedFormat:@"11/09/19 9:15:18" withLimitSec:1000000 withComment:@"実際にAssertionが炸裂するかどうかの実装は、TimeMineを使おう。国際は一応固定で。"];
}

- (void) hearing:(NSNotification * )notif {
//    NSLog(@"hearing %@",notif);
}


/**
 Master Delegate
 */
- (void)receiveCenter:(NSNotification * )notif {
    NSString * exec = [messenger getExecFromNortification:notif];
    NSDictionary * dict = [messenger getTagValueDictionaryFromNotification:notif];

    if ([exec isEqualToString:@"lineStarted"]) {
        NSPoint inWindowStartPoint = [[dict valueForKey:@"startPoint"] pointValue];
        NSPoint inWindowEndPoint = [[dict valueForKey:@"endPoint"] pointValue];
       
        NSPoint outerStartPoint = NSMakePoint(window.frame.origin.x+inWindowStartPoint.x, window.frame.origin.y+inWindowStartPoint.y);
        
        NSLog(@"outerStartPoint  x   %f", outerStartPoint.x); 
        NSLog(@"outerStartPoint  y   %f", outerStartPoint.y);
        
        NSPoint outerEndPoint = NSMakePoint(window.frame.origin.x+inWindowEndPoint.x, window.frame.origin.y+inWindowEndPoint.y);
        
        NSValue * startPointWrapper = [NSValue valueWithPoint:outerStartPoint];
        NSValue * endPointWrapper = [NSValue valueWithPoint:outerEndPoint];
        
        [messenger call:POINTEDWINDW_CONT withExec:@"move", 
         [messenger tag:@"startPoint" val:startPointWrapper],
         [messenger tag:@"endPoint" val:endPointWrapper],
          nil];
    }
    
    if ([exec isEqualToString:@"lineDropped"]) {
        [messenger call:POINTEDWINDW_CONT withExec:@"remove", 
         nil];
    }
    
    
    

}

- (IBAction)a:(id)sender {
    [messenger callMyself:@"test",
     [messenger tag:@"sender" val:sender],
     nil];
}



@end
