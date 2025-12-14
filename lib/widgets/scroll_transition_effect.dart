import 'package:flutter/material.dart';

class ScrollTransitionEffect extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final double beginOpacity;
  final double endOpacity;
  final double beginScale;
  final double endScale;
  final Offset beginOffset;
  final Offset endOffset;
  final Curve curve;
  final Duration duration;

  const ScrollTransitionEffect({
    super.key,
    required this.child,
    required this.controller,
    this.beginOpacity = 0.0,
    this.endOpacity = 1.0,
    this.beginScale = 0.94,
    this.endScale = 1.0,
    this.beginOffset = const Offset(0, 60),
    this.endOffset = Offset.zero,
    this.curve = Curves.easeOutCubic,
    this.duration = const Duration(milliseconds: 700),
  });

  @override
  State<ScrollTransitionEffect> createState() => _ScrollTransitionEffectState();
}

class _ScrollTransitionEffectState extends State<ScrollTransitionEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  late Animation<Offset> _offset;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(begin: widget.beginOpacity, end: widget.endOpacity)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _scale = Tween<double>(begin: widget.beginScale, end: widget.endScale)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _offset = Tween<Offset>(begin: widget.beginOffset, end: widget.endOffset)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndTrigger());
    widget.controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_triggered) {
      _checkAndTrigger();
    }
  }

  void _checkAndTrigger() {
    if (!mounted) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;
    // Trigger when top enters viewport with small preload
    final preload = 120.0;
    final entersViewport = position.dy < screenHeight - preload && position.dy + size.height > 0;
    if (entersViewport && !_triggered) {
      _triggered = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: _offset.value,
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}


