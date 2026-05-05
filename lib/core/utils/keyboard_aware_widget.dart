import 'package:flutter/material.dart';

/// Keeps the focused text field visible when the soft keyboard is open.
///
/// Wraps [child] in a scroll view and adds bottom padding equal to the
/// keyboard height so content is never obscured. When focus moves to a
/// field, [Scrollable.ensureVisible] is called with [alignment] so the
/// field sits near the top of the visible area, leaving room for any
/// widgets (e.g. a submit button) that follow it.
class KeyboardAwareScroll extends StatefulWidget {
  const KeyboardAwareScroll({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.alignment = 0.2,
  });

  final Widget child;
  final EdgeInsets padding;

  /// Where the focused widget lands in the visible viewport (0 = top, 1 = bottom).
  final double alignment;

  @override
  State<KeyboardAwareScroll> createState() => _KeyboardAwareScrollState();
}

class _KeyboardAwareScrollState extends State<KeyboardAwareScroll>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FocusManager.instance.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    FocusManager.instance.removeListener(_onFocusChange);
    _scrollController.dispose();
    super.dispose();
  }

  // Fires when the keyboard opens/closes.
  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding
        .instance
        .platformDispatcher
        .views
        .first
        .viewInsets
        .bottom;

    if (bottomInset > 0) _scrollToFocused();
  }

  // Fires when focus moves between widgets (keyboard already open).
  void _onFocusChange() {
    if (!mounted) return;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    if (bottomInset == 0) return;
    _scrollToFocused();
  }

  void _scrollToFocused() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final focusedContext = FocusManager.instance.primaryFocus?.context;
      if (focusedContext == null) return;
      Scrollable.ensureVisible(
        focusedContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        alignment: widget.alignment,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: widget.padding.copyWith(bottom: bottomInset),
      child: SingleChildScrollView(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: widget.child,
      ),
    );
  }
}
