//
//  OrzIntrospect.h
//
//  Created by Domestic Cat on 29/04/11.
//

#define kOrzIntrospectNotificationIntrospectionDidStart @"kOrzIntrospectNotificationIntrospectionDidStart"
#define kOrzIntrospectNotificationIntrospectionDidEnd @"kOrzIntrospectNotificationIntrospectionDidEnd"
#define kOrzIntrospectAnimationDuration 0.08

#import <objc/runtime.h>
#import "TargetConditionals.h"


@class OrzFrameView;
@class OrzStatusBarOverlay;
@protocol UITextViewDelegate;
@protocol OrzFrameViewDelegate;

#ifdef DEBUG

@interface UIView (debug)

- (NSString *)recursiveDescription;

@end

#endif

@interface OrzIntrospect : NSObject

@property (nonatomic) BOOL keyboardBindingsOn;									// default: YES
@property (nonatomic) BOOL showStatusBarOverlay;								// default: YES
@property (nonatomic) UIGestureRecognizer *invokeGestureRecognizer;		// default: nil

@property (nonatomic) BOOL on;
@property (nonatomic) BOOL handleArrowKeys;
@property (nonatomic) BOOL viewOutlines;
@property (nonatomic) BOOL highlightNonOpaqueViews;
@property (nonatomic) BOOL flashOnRedraw;
@property (nonatomic) OrzFrameView *frameView;
@property (nonatomic) UITextView *inputTextView;
@property (nonatomic) OrzStatusBarOverlay *statusBarOverlay;

@property (nonatomic) NSMutableDictionary *objectNames;

@property (nonatomic, weak) UIView *currentView;
@property (nonatomic) CGRect originalFrame;
@property (nonatomic) CGFloat originalAlpha;
@property (nonatomic) NSMutableArray *currentViewHistory;

@property (nonatomic) BOOL showingHelp;


/**
 * default config for app
 *
 * should be called in app life event function:
 *
 * - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
 */
+ (void)defaultConfig;

///////////
// Setup //
///////////

+ (OrzIntrospect *)sharedIntrospector;		// this returns nil when NOT in DEGBUG mode
- (void)start;								// NOTE: call setup AFTER [window makeKeyAndVisible] so statusBarOrientation is reported correctly.

////////////////////
// Custom Setters //
////////////////////

- (void)setInvokeGestureRecognizer:(UIGestureRecognizer *)newGestureRecognizer;
- (void)setKeyboardBindingsOn:(BOOL)keyboardBindingsOn;

//////////////////
// Main Actions //
//////////////////

- (void)invokeIntrospector;					// can be called manually
- (void)touchAtPoint:(CGPoint)point;		// can be called manually
- (void)selectView:(UIView *)view;
- (void)statusBarTapped;

//////////////////////
// Keyboard Capture //
//////////////////////

- (void)textViewDidChangeSelection:(UITextView *)textView;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)string;

/////////////////////////////////
// Logging Code & Object Names //
/////////////////////////////////

- (void)logCodeForCurrentViewChanges;

// make sure all names that are added are removed at dealloc or else they will be retained here!
- (void)setName:(NSString *)name forObject:(id)object accessedWithSelf:(BOOL)accessedWithSelf;
- (NSString *)nameForObject:(id)object;
- (void)removeNamesForViewsInView:(UIView *)view;
- (void)removeNameForObject:(id)object;

////////////
// Layout //
////////////

- (void)updateFrameView;
- (void)updateStatusBar;
- (void)updateViews;
- (void)showTemporaryStringInStatusBar:(NSString *)string;

/////////////
// Actions //
/////////////

- (void)logRecursiveDescriptionForCurrentView;
- (void)logRecursiveDescriptionForView:(UIView *)view;
- (void)forceSetNeedsDisplay;
- (void)forceSetNeedsLayout;
- (void)forceReloadOfView;
- (void)toggleOutlines;
- (void)addOutlinesToFrameViewFromSubview:(UIView *)view;
- (void)toggleNonOpaqueViews;
- (void)setBackgroundColor:(UIColor *)color ofNonOpaqueViewsInSubview:(UIView *)view;
- (void)toggleRedrawFlashing;
- (void)callDrawRectOnViewsInSubview:(UIView *)subview;
- (void)flashRect:(CGRect)rect inView:(UIView *)view;

/////////////////////////////
// (Somewhat) Experimental //
/////////////////////////////

- (void)logPropertiesForCurrentView;
- (void)logPropertiesForObject:(id)object;
- (void)logAccessabilityPropertiesForObject:(id)object;
- (NSArray *)subclassesOfClass:(Class)parentClass;

/////////////////////////
// Description Methods //
/////////////////////////

- (NSString *)describeProperty:(NSString *)propertyName value:(id)value;
- (NSString *)describeColor:(UIColor *)color;

/////////////////////////
// OrzIntrospector Help //
/////////////////////////

- (void)toggleHelp;

////////////////////
// Helper Methods //
////////////////////

- (UIWindow *)mainWindow;
- (NSMutableArray *)viewsAtPoint:(CGPoint)touchPoint inView:(UIView *)view;
- (void)fadeView:(UIView *)view toAlpha:(CGFloat)alpha;
- (BOOL)view:(UIView *)view containsSubview:(UIView *)subview;
- (BOOL)shouldIgnoreView:(UIView *)view;

@end
