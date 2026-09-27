// custom_button.dart — A reusable, styled button widget.
// Creating reusable widgets avoids repeating the same ElevatedButton
// code on every screen, keeping our codebase DRY and easy to change.

import 'package:flutter/material.dart';

/// CustomButton is a StatelessWidget because it has no internal state.
/// It simply displays whatever [label] and [onPressed] are passed to it.
class CustomButton extends StatelessWidget {
  /// The text displayed on the button
  final String label;

  /// The function called when the button is tapped.
  /// VoidCallback is just a typedef for `void Function()`.
  final VoidCallback onPressed;

  /// Optional: whether the button shows a loading spinner
  final bool isLoading;

  /// Optional: a custom background color (defaults to Leaf Green)
  final Color? backgroundColor;

  // const constructors let Flutter optimize re-builds
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // double.infinity makes the button stretch to fill its parent width
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        // When isLoading is true we pass null to disable the button
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF3E8E55),
          foregroundColor: const Color(0xFFFDFBF7),
          elevation: 4,
          shadowColor: const Color(0xFF3E8E55).withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // Show a spinner while loading, otherwise show the label text
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFFFDFBF7)),
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}
