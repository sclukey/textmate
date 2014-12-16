#import <OakTextView/OakDocumentView.h>
#import <OakTextView/OakTextView.h>

@interface DocumentSplitsView : NSView
@property (nonatomic) OakDocumentView* documentView;
@property (nonatomic) NSInteger currentViewIndex;
@property (nonatomic) BOOL hideStatusBar;

- (OakTextView*)getTextView;
- (NSIndexSet*)splitsWithDocuments:(std::vector<document::document_ptr>)documents;
- (BOOL)createSplit:(bool)isVertical;
- (void)centerNewSplit;
- (void)removeCurrentSplit;
- (void)removeOtherSplits;
- (void)setThemeWithUUID:(NSString*)themeUUID;
- (void)selectNext;
- (void)selectPrevious;
- (void)removeTextViewDelegates;
- (void)setDocument:(document::document_ptr)aDocument atIndex:(NSInteger)index;
@end
