#import <OakTextView/OakDocumentView.h>
#import <OakTextView/OakTextView.h>

@interface DocumentSplitsView : NSView
@property (nonatomic) OakDocumentView* documentView;
@property (nonatomic) BOOL hideStatusBar;

- (OakTextView*)getTextView;
- (void)setThemeWithUUID:(NSString*)themeUUID;
- (void)removeTextViewDelegates;
@end
