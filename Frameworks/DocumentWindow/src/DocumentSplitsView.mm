#import "DocumentSplitsView.h"
#import <OakTextView/OakDocumentView.h>
#import <oak/debug.h>

@interface OakSplitView : NSSplitView
@end

@implementation OakSplitView
+ (BOOL)requiresConstraintBasedLayout
{
	return YES;
}
@end

@interface DocumentSplitsView ()
@property (nonatomic) NSMutableArray* myConstraints;
@property (nonatomic) OakSplitView* splitView;
@property (nonatomic) NSMutableArray* documentViews;
@property (nonatomic) NSInteger centeringIndex;
@end

@implementation DocumentSplitsView { OBJC_WATCH_LEAKS(ProjectLayoutView); }
- (id)initWithFrame:(NSRect)aRect
{
	if(self = [super initWithFrame:aRect])
	{
		_myConstraints = [NSMutableArray array];
		_documentViews = [NSMutableArray array];
		
		_centeringIndex = -1;
		
		self.splitView = [[OakSplitView alloc] initWithFrame:aRect];
		[self.splitView setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:self.splitView];
		[self.splitView setDividerStyle:NSSplitViewDividerStyleThin];
		
		[self createSplit:YES];
	}
	return self;
}

- (BOOL)createSplit:(bool)isVertical
{
	[self setDocumentView:[[OakDocumentView alloc] init]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDocumentView:) name:@"OakTextViewDidBecomeFirstResponder" object:self.documentView.textView];
	[self.documentView setTranslatesAutoresizingMaskIntoConstraints:NO];
	[_documentViews addObject:self.documentView];
	[self.splitView setVertical:isVertical];
	[self.splitView addSubview:self.documentView];
	_centeringIndex = [[self.splitView subviews] count] - 2;
	[self.splitView adjustSubviews];
	
	return YES;
}

- (void)centerNewSplit
{
	if(_centeringIndex >= 0)
	{
		CGFloat position = ([self.splitView minPossiblePositionOfDividerAtIndex:_centeringIndex] - [self.splitView maxPossiblePositionOfDividerAtIndex:_centeringIndex]) / 2 + [self.splitView maxPossiblePositionOfDividerAtIndex:_centeringIndex];
		[self.splitView setPosition:position ofDividerAtIndex:_centeringIndex];
		if(position > 0)
			_centeringIndex = -1;
	}
}

- (void)updateDocumentView:(NSNotification*)aNotification
{
	NSView* textView = [aNotification object];
	for(OakDocumentView *thisDocument in _documentViews)
	{
		if(textView == thisDocument.textView)
		{
			self.documentView = thisDocument;
			[self centerNewSplit];
			[[NSNotificationCenter defaultCenter] postNotificationName:@"OakSplitViewDocumentChanged" object:self];
			break;
		}
	}
}

- (void)removeCurrentSplit
{
	if ([_documentViews count] > 1)
	{
		[_documentViews removeObject:self.documentView];
		[self.documentView removeFromSuperview];
		self.documentView = [_documentViews firstObject];
	}
}

- (OakTextView*)getTextView
{
	return self.documentView.textView;
}

- (void)setThemeWithUUID:(NSString*)themeUUID
{
	for (OakDocumentView* docView in _documentViews)
	{
		[docView setThemeWithUUID:themeUUID];
	}
}

- (void)setHideStatusBar:(BOOL)flag
{
	_hideStatusBar = flag;
	for (OakDocumentView* docView in _documentViews)
	{
		docView.hideStatusBar = flag;
	}
}

- (void)removeTextViewDelegates
{
	for (OakDocumentView* docView in _documentViews)
	{
		docView.textView.delegate = nil;
	}
}

- (void)setDocumentView:(OakDocumentView*)aDocumentView
{
	_documentView = aDocumentView;
}

#ifndef CONSTRAINT
#define CONSTRAINT(str, align) [_myConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:str options:align metrics:nil views:views]]
#endif

- (void)updateConstraints
{
	[self removeConstraints:_myConstraints];
	[_myConstraints removeAllObjects];
	[super updateConstraints];

	NSDictionary* views = @{
		@"documentView"               : self.splitView,
	};

	CONSTRAINT(@"V:|[documentView]|", 0);
	CONSTRAINT(@"H:|[documentView]|", 0);

	[self addConstraints:_myConstraints];
	[[self window] invalidateCursorRectsForView:self];
}

#undef CONSTRAINT

@end
