//
//  TimeAssertMinerAppDelegate.m
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import "TimeAssertMinerAppDelegate.h"
#import "SmallControllViewController.h"

#import "TimeAssertMinerConstSetting.h"

#import "TimeMine.h"

@implementation TimeAssertMinerAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    messenger = [[MessengerSystem alloc]initWithBodyID:self withSelector:@selector(receiveCenter:) withName:MASTER_DELEGATE]; 

    SmallControllViewController * tViewCont = [[SmallControllViewController alloc]init];
    [window setContentView:tViewCont.view];
    
    
    [TimeMine setTimeMineLocalizedFormat:@"11/09/19 9:04:14" withLimitSec:1000000 withComment:@"grepについて調べる。インターフェースとして、用件はまとめてあるので、どうやるか。　かなり後回し。用件が多い。"];
    
    
    [TimeMine setTimeMineLocalizedFormat:@"11/09/19 9:15:18" withLimitSec:1000000 withComment:@"実際にAssertionが炸裂するかどうかの実装は、TimeMineを使おう。国際は一応固定で。"];
    
    
}


/**
 Master Delegate
 */
- (void)receiveCenter:(NSNotification * )notif {
    NSDictionary * dict = [messenger getTagValueDictionaryFromNotification:notif];

//    [messenger getExecFromNortification:notif];
    NSLog(@"マスターになんか到達  %@",    [dict valueForKey:@"sender"]);
}

- (IBAction)a:(id)sender {
    [messenger callMyself:@"test",
     [messenger tag:@"sender" val:sender],
     nil];
}



@end
