//
//  TesttypeViewController.h
//  TimeAssertMiner
//
//  Created by 徹 井上 on 11/09/19.
//  Copyright 2011年 KISSAKI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MessengerSystem.h"

#define MODE_ObjectiveC (0)
#define MODE_GWT (1)

@interface SmallControllViewController : NSViewController
{
    MessengerSystem * messenger;
    IBOutlet NSTextFieldCell *nowTimeDescription;
    IBOutlet NSTextFieldCell *nowTimeDistance;
    IBOutlet NSTextFieldCell *TimeText;
    IBOutlet NSTextFieldCell *justCopiedText;
    IBOutlet NSButton *languageCell;
    
    IBOutlet NSTextFieldCell *timeAssertTextBase;
    NSDictionary * languageDict;
}

- (NSString * ) timeAssertText:(NSString * )time withLimit:(NSString * )timeLimitStr withMessage:(NSString * )message byType:(int)currentMode;

- (IBAction)clockIndicatorChanged:(id)sender;
- (IBAction)languageTapped:(id)sender;

@end
