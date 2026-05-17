import 'package:flutter/material.dart';

class ScrollTriggeredLoadingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double blurRadius;
  final Color backgroundColor;

  const ScrollTriggeredLoadingWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2300),
    this.blurRadius = 25.0,
    this.backgroundColor = Colors.black,
  });

  @override
  State<ScrollTriggeredLoadingWidget> createState() =>
      _ScrollTriggeredLoadingWidgetState();
}

class _ScrollTriggeredLoadingWidgetState
    extends State<ScrollTriggeredLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation = Tween<double>(begin: 60.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    // Use a more efficient visibility check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (_hasTriggered || !mounted) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;

    // Trigger when widget is 200px before entering viewport
    if (position.dy < screenHeight + 200) {
      _hasTriggered = true;
      setState(() {});
      _controller.forward();
    } else {
      // Check again after a short delay
      Future.delayed(const Duration(milliseconds: 100), _checkVisibility);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Return only the animated content without overlay stack
        return Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(opacity: _fadeAnimation.value, child: widget.child),
          ),
        );
      },
    );
  }
}
