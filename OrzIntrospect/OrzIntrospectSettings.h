//////////////
// Settings //
//////////////

#define kOrzIntrospectFlashOnRedrawColor [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.4f]	// UIColor
#define kOrzIntrospectFlashOnRedrawFlashLength 0.03f													// NSTimeInterval
#define kOrzIntrospectOpaqueColor [UIColor redColor]													// UIColor
#define kOrzIntrospectTemporaryDisableDuration 10.                                                      // Seconds

//////////////////
// Key Bindings //
//////////////////

// '' is equivalent to page up (copy and paste this character to use)
// '' is equivalent to page down (copy and paste this character to use)

// Global //
#define kOrzIntrospectKeysInvoke							@" "		// starts introspector
#define kOrzIntrospectKeysToggleViewOutlines				@"o"		// shows outlines for all views
#define kOrzIntrospectKeysToggleNonOpaqueViews			    @"O"		// changes all non-opaque view background colours to red (destructive)
#define kOrzIntrospectKeysToggleHelp						@"?"		// shows help
#define kOrzIntrospectKeysToggleFlashViewRedraws			@"f"		// toggle flashing on redraw for all views that implement [[OrzIntrospect sharedIntrospector] flashRect:inView:] in drawRect:
#define kOrzIntrospectKeysToggleShowCoordinates			    @"c"		// toggles the coordinates display
#define kOrzIntrospectKeysEnterBlockMode					@"b"		// enters block action mode

// When introspector is invoked and a view is selected //
#define kOrzIntrospectKeysNudgeViewLeft					    @"4"		// nudges the selected view in given direction
#define kOrzIntrospectKeysNudgeViewRight				    @"6"		//
#define kOrzIntrospectKeysNudgeViewUp					    @"8"		//
#define kOrzIntrospectKeysNudgeViewDown					    @"2"		//
#define kOrzIntrospectKeysCenterInSuperview				    @"5"		// centers the selected view in it's superview
#define kOrzIntrospectKeysIncreaseWidth					    @"9"		// increases/decreases the width/height of selected view
#define kOrzIntrospectKeysDecreaseWidth					    @"7"		//
#define kOrzIntrospectKeysIncreaseHeight					@"3"		//
#define kOrzIntrospectKeysDecreaseHeight					@"1"		//
#define kOrzIntrospectKeysLogCodeForCurrentViewChanges	    @"0"		// prints code to the console of the changes to the current view.  If the view has not been changed nothing will be printed.  For example, if you nudge a view or change it's rect with the nudge keys, this will log 'view.frame = CGRectMake(50.0, ..etc);'.  Or if you set it's name using setName:forObject:accessedWithSelf: it will use the name provided, for example 'myView.frame = CGRectMake(...);'.  Setting accessedWithSelf to YES would output 'self.myView.frame = CGRectMake(...);'.

#define kOrzIntrospectKeysIncreaseViewAlpha				    @"+"		// increases/decreases the selected views alpha value
#define kOrzIntrospectKeysDecreaseViewAlpha				    @"-"		//

#define kOrzIntrospectKeysSetNeedsDisplay				    @"d"		// calls setNeedsDisplay on selected view
#define kOrzIntrospectKeysSetNeedsLayout					@"l"		// calls setNeedsLayout on selected view
#define kOrzIntrospectKeysReloadData						@"r"		// calls reloadData on selected view if it's a UITableView
#define kOrzIntrospectKeysLogProperties					    @"p"		// logs all properties of the selected view
#define kOrzIntrospectKeysLogAccessibilityProperties		@"a"		// logs accessibility info (useful for automated view tests - thanks to @samsoffes for the idea)
#define kOrzIntrospectKeysLogViewRecursive				    @"v"		// calls private method recursiveDescription which logs selected view heirachy

#define kOrzIntrospectKeysMoveUpInViewHierarchy			    @"y"		// changes the selected view to it's superview
#define kOrzIntrospectKeysMoveBackInViewHierarchy		    @"t"		// changes the selected view back to the previous view selected (after using the above command)

#define kOrzIntrospectKeysMoveDownToFirstSubview			@"h"
#define kOrzIntrospectKeysMoveToNextSiblingView			    @"j"
#define kOrzIntrospectKeysMoveToPrevSiblingView			    @"g"

#define kOrzIntrospectKeysEnterGDB						    @"`"			// enters GDB
#define kOrzIntrospectKeysDisableForPeriod		            @"~"			// disables OrzIntrospect for a given period (see kOrzIntrospectTemporaryDisableDuration)
