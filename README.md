# Mouse tracking and dragging test
## NSTrackingArea and `mouseDown:`/`mouseDragged:`/`mouseUp:`: Fight!

My real app has a view that both tracks mouse movements over it (showing a subview that follows the mouse and a popover that follows the subview) and allows the user to drag one of its subviews around within it.

Dragging is constrained to this view (it's a scrubber bar with a draggable thumb), so there's nothing that the user can drag out of it, but I would like for the user to be able to move the mouse outside of the view and have the thumb continue following the user's movements. Ideally, I'd like to have a gearing feature where dragging the mouse a certain distance from the scrubber reduces the thumb movement rate, like the scrubber in iOS's video player view.

The problem is, if I have my tracking area in place, dragging outside of the view results in a `mouseExited:` message and no further drag messages. I don't even get a `mouseUp:` if I come back to the view before releasing the mouse. For that matter, I don't even get any more tracking area messages, either, until I've released the mouse.
