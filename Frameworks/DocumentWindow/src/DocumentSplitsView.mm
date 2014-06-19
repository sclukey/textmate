#import "DocumentSplitsView.h"
#import <oak/debug.h>

@interface DocumentSplitsView ()
@property (nonatomic) NSMutableArray* myConstraints;
@end

@implementation DocumentSplitsView { OBJC_WATCH_LEAKS(ProjectLayoutView); }
- (id)initWithFrame:(NSRect)aRect
{
	if(self = [super initWithFrame:aRect])
	{
		_myConstraints = [NSMutableArray array];
	}
	return self;
}

- (NSView*)replaceView:(NSView*)oldView withView:(NSView*)newView
{
	if(newView == oldView)
		return oldView;

	[oldView removeFromSuperview];

	if(newView)
	{
		[newView setTranslatesAutoresizingMaskIntoConstraints:NO];
		[self addSubview:newView];
	}

	[self setNeedsUpdateConstraints:YES];
	return newView;
}

- (void)setActiveDocumentView:(NSView*)aDocumentView
{
	_activeDocumentView = [self replaceView:_activeDocumentView withView:aDocumentView];
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
		@"documentView"               : _activeDocumentView,
	};

	CONSTRAINT(@"V:|[documentView]|", 0);
	CONSTRAINT(@"H:|[documentView]|", 0);

	[self addConstraints:_myConstraints];
	[[self window] invalidateCursorRectsForView:self];
}

#undef CONSTRAINT

@end
