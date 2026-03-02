import 'package:flutter/material.dart';

extension FormAutoScroll on GlobalKey<FormState> {
  /// Validates the form and scrolls to the first field with an error.
  /// [alignment] 0.0 means top of viewport, 1.0 means bottom.
  /// [duration] defaults to 300ms for a snappier feel.
  bool validateAndScroll({
    double alignment = 0.1,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOutCubic,
  }) {
    final FormState? form = currentState;
    if (form == null) return false;

    final bool isValid = form.validate();
    if (isValid) return true;

    Element? bestCandidate;
    double? minTopOffset;

    void findFirstVisualError(Element element) {
      if (element.widget is FormField) {
        // Safe check for state instead of forced casting
        final dynamic state = (element as StatefulElement).state;

        if (state is FormFieldState && state.hasError) {
          final RenderBox? box = element.findRenderObject() as RenderBox?;
          if (box != null && box.hasSize) {
            // Get the global vertical position of this field
            final double top = box.localToGlobal(Offset.zero).dy;

            // We want the field that is physically closest to the top of the screen
            if (minTopOffset == null || top < minTopOffset!) {
              minTopOffset = top;
              bestCandidate = element;
            }
          }
        }
      }
      // Continue traversing to find all potential errors before deciding
      element.visitChildren(findFirstVisualError);
    }

    currentContext?.visitChildElements(findFirstVisualError);

    if (bestCandidate != null) {
      Scrollable.ensureVisible(
        bestCandidate!,
        duration: duration,
        curve: curve,
        alignment: alignment,
      );
    }

    return false;
  }
}