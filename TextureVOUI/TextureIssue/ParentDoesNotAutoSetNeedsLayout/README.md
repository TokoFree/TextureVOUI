#  ChipNode Issue
If you open `ParentNodeSetNeedsLayoutVC.swift` 

Discussion Result:
In `ParentNodeSetNeedsLayoutVC.swift`
- `displaysAsynchronously` (not related)
- `flexShrink`. (issue still persist)
- Setting `style.minWidth`. (after setting minWidth, it works well, but when setting minWidth that smaller than intrinsic size of the chips, the issue re-occured)
- Why need to set `style.height`, instead of use padding? So the size still be the same regardless the content size, this can cause problem if later we introduce dynamic font size.
- kita harus set Attribute Text dr textNode sebelum init selesai.

In `ParentNodeSuccessSetNeedsLayoutVC.swift`
- empty/nil text in init, then set text in di didLoad and do the `setNeedsLayout`, the issue happened.
- But if you add DispatchQueue.main.async { setNeedsLayout } or using transitionLayout, the issue didn't happen.
- When changing selected chip (between first and third) using setNeedsLayout, the layoutSpec printed once, using dispatchqueue and transition, the layoutSpec run twice.
