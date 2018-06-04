/*:
## Flo tutorial notes
 ---
iOS updates the context by calling draw(_:) whenever the view needs to be updated.This happens when:
* The view is new to the screen.
* Other views on top of it are moved.
* The view’s hidden property is changed.
* Your app explicitly calls the setNeedsDisplay() or setNeedsDisplayInRect() methods on the view.

 A **UIBezierPath** is a wrapper for a **CGMutablePath**, which is the lower-level Core Graphics API

 ##### Pixels vs points

 ![Pixels vs points](1-Pixels-700x263.png)

 Strokes draw outwards from the center of the path whereas fills only draw inside the path.
*/
