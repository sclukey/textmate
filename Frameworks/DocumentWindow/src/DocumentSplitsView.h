#import <OakTextView/OakDocumentView.h>
#import <OakTextView/OakTextView.h>

@interface DocumentSplitsView : NSView
@property (nonatomic) OakDocumentView* documentView;
@property (nonatomic) BOOL hideStatusBar;

- (OakTextView*)getTextView;
- (void)createSplit:(bool)isVertical;
- (void)removeCurrentSplit;
- (void)setThemeWithUUID:(NSString*)themeUUID;
- (void)removeTextViewDelegates;
@end
