//
//  OrzStatusBarOverlay.h
//
//  Copyright 2011 Domestic Cat. All rights reserved.
//

// Based mainly on @myellow's excellent MTStatusBarOverlay: https://github.com/myell0w/MTStatusBarOverlay


#import "OrzIntrospectSettings.h"

#define kOrzIntrospectNotificationStatusBarTapped @"kOrzIntrospectNotificationStatusBarTapped"

@interface OrzStatusBarOverlay : UIWindow

@property (nonatomic) UILabel *leftLabel;
@property (nonatomic) UILabel *rightLabel;

///////////
// Setup //
///////////

- (id)init;
- (void)updateBarFrame;

/////////////
// Actions //
/////////////

- (void)tapped;

@end
