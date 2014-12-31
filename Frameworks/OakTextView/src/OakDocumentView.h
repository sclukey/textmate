#import "OakTextView.h"
#import <document/document.h>
#import <oak/debug.h>

PUBLIC @interface OakDocumentView : NSView
@property (nonatomic, readonly) OakTextView* textView;
@property (nonatomic) document::document_ptr const& document;
@property (nonatomic) BOOL hideStatusBar;
- (IBAction)toggleLineNumbers:(id)sender;
- (IBAction)takeThemeUUIDFrom:(id)sender;

- (void)setThemeWithUUID:(NSString*)themeUUID;

- (void)addAuxiliaryView:(NSView*)aView atEdge:(NSRectEdge)anEdge;
- (void)removeAuxiliaryView:(NSView*)aView;

- (IBAction)showSymbolChooser:(id)sender;

- (void)setDocument:(document::document_ptr const&)aDocument quietly:(BOOL)quiet;
- (void)setDocument:(document::document_ptr const&)aDocument;
@end
