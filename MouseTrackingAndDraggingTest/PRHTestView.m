#import "PRHTestView.h"

@interface PRHTestView ()

- (void) drawCrossCenteredAtPoint:(NSPoint)point inColor:(NSColor *)color;

@end

@implementation PRHTestView
{
	NSTrackingArea *_trackingArea;
	NSPoint _hoverPoint;
	NSPoint _dragPoint;
}

- (void) updateTrackingAreas {
	if (_trackingArea)
		[self removeTrackingArea:_trackingArea];

	_trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
												 options:NSTrackingActiveInKeyWindow | NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved
												   owner:self
												userInfo:nil];
	[self addTrackingArea:_trackingArea];
}

- (void) drawRect:(NSRect)dirtyRect {
	[self drawCrossCenteredAtPoint:_hoverPoint inColor:[NSColor grayColor]];
	[self drawCrossCenteredAtPoint:_dragPoint inColor:[NSColor blueColor]];
}

- (NSRect) rectForCrossCenteredAtPoint:(NSPoint)centerPoint {
	CGFloat crossDiameter = 16.0;
	CGFloat crossRadius = crossDiameter / 2.0;
	NSRect rect = {
		{ centerPoint.x - crossRadius, centerPoint.y - crossRadius },
		{ crossDiameter, crossDiameter }
	};
	return rect;
}

- (void) drawCrossCenteredAtPoint:(NSPoint)point inColor:(NSColor *)color {
	CGFloat crossDiameter = [self rectForCrossCenteredAtPoint:point].size.width;
	CGFloat crossRadius = crossDiameter / 2.0;

	NSBezierPath *path = [NSBezierPath bezierPath];
	[path moveToPoint:(NSPoint){ point.x - crossRadius, point.y }];
	[path lineToPoint:(NSPoint){ point.x + crossRadius, point.y }];
	[path moveToPoint:(NSPoint){ point.x, point.y - crossRadius }];
	[path lineToPoint:(NSPoint){ point.x, point.y + crossRadius }];
	[color setStroke];
	[path stroke];
}

- (NSPoint) locationInSelfFromEvent:(NSEvent *)event {
	return [self convertPoint:event.locationInWindow fromView:nil];
}

- (void) mouseEntered:(NSEvent *)theEvent {
	NSLog(@"%s", __func__);
	_hoverPoint = [self locationInSelfFromEvent:theEvent];
	[self setNeedsDisplayInRect:[self rectForCrossCenteredAtPoint:_hoverPoint]];
}

- (void) mouseMoved:(NSEvent *)theEvent {
	NSLog(@"%s", __func__);
	[self setNeedsDisplayInRect:[self rectForCrossCenteredAtPoint:_hoverPoint]];
	_hoverPoint = [self locationInSelfFromEvent:theEvent];
	[self setNeedsDisplayInRect:[self rectForCrossCenteredAtPoint:_hoverPoint]];
}

- (void) mouseExited:(NSEvent *)theEvent {
	NSLog(@"%s", __func__);
	_hoverPoint = [self locationInSelfFromEvent:theEvent];
	[self setNeedsDisplayInRect:[self rectForCrossCenteredAtPoint:_hoverPoint]];
}

- (void) mouseDown:(NSEvent *)theEvent {
	NSLog(@"%s", __func__);
	_dragPoint = [self locationInSelfFromEvent:theEvent];
	[self setNeedsDisplayInRect:[self rectForCrossCenteredAtPoint:_dragPoint]];
}

- (void) mouseDragged:(NSEvent *)theEvent {
	NSLog(@"%s", __func__);
	[self setNeedsDisplayInRect:[self rectForCrossCenteredAtPoint:_dragPoint]];
	_dragPoint = [self locationInSelfFromEvent:theEvent];
	[self setNeedsDisplayInRect:[self rectForCrossCenteredAtPoint:_dragPoint]];
}

- (void) mouseUp:(NSEvent *)theEvent {
	NSLog(@"%s", __func__);
	_dragPoint = [self locationInSelfFromEvent:theEvent];
	[self setNeedsDisplayInRect:[self rectForCrossCenteredAtPoint:_dragPoint]];
}

@end
