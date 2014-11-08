#import <OakTextView/OakDocumentView.h>
#import <OakTextView/OakTextView.h>

@interface DocumentSplitsView : NSView
@property (nonatomic) OakDocumentView* documentView;
@property (nonatomic) BOOL hideStatusBar;

- (OakTextView*)getTextView;
- (BOOL)createSplit:(bool)isVertical;
- (void)centerNewSplit;
- (void)removeCurrentSplit;
- (void)setThemeWithUUID:(NSString*)themeUUID;
- (void)removeTextViewDelegates;
@end
