//
//  OrzFrameView.h
//
//  Created by Domestic Cat on 29/04/11.
//

#import <QuartzCore/QuartzCore.h>
#import "OrzCrossHairView.h"

@protocol OrzFrameViewDelegate <NSObject>

@required

- (void)touchAtPoint:(CGPoint)point;

@end

@interface OrzFrameView : UIView

@property (nonatomic, weak) id<OrzFrameViewDelegate> delegate;
@property (nonatomic) CGRect mainRect;
@property (nonatomic) CGRect superRect;
@property (nonatomic) UILabel *touchPointLabel;
@property (nonatomic) NSMutableArray *rectsToOutline;
@property (nonatomic) OrzCrossHairView *touchPointView;

///////////
// Setup //
///////////

- (id)initWithFrame:(CGRect)frame delegate:(id)aDelegate;

////////////////////
// Custom Setters //
////////////////////

- (void)setMainRect:(CGRect)newMainRect;
- (void)setSuperRect:(CGRect)newSuperRect;

/////////////////////
// Drawing/Display //
/////////////////////

- (void)drawRect:(CGRect)rect;

////////////////////
// Touch Handling //
////////////////////

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
