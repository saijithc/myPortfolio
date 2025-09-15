import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';

class ScrollBlurOverlay extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final double blurHeight;
  final Duration fadeDuration;

  const ScrollBlurOverlay({
    super.key,
    required this.child,
    required this.scrollController,
    this.blurHeight = 100,
    this.fadeDuration = const Duration(milliseconds: 800),
  });

  @override
  State<ScrollBlurOverlay> createState() => _ScrollBlurOverlayState();
}

class _ScrollBlurOverlayState extends State<ScrollBlurOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _blurAnimation;
  bool _isScrolling = false;
  bool _isScrollingDown = true;
  Timer? _scrollTimer;
  double _lastScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.fadeDuration,
      vsync: this,
    );

    _blurAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    ));

    // Initialize scroll position only if controller is attached
    if (widget.scrollController.hasClients) {
      _lastScrollPosition = widget.scrollController.position.pixels;
    }
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    _controller.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted || !widget.scrollController.hasClients) {
     
      return;
    }

    final currentPosition = widget.scrollController.position.pixels;
    final scrollDelta = currentPosition - _lastScrollPosition;
    final isScrollingDown = scrollDelta > 1; // Reduced threshold
    final isScrollingUp = scrollDelta < -1;
    final isAtTop = currentPosition <= 0;
    final isAtBottom = currentPosition >= widget.scrollController.position.maxScrollExtent;
    
   
    // Update direction immediately when scrolling
    if (isScrollingDown) {
      if (_isScrollingDown != true) {
        setState(() {
          _isScrollingDown = true;
        });
      }
    } else if (isScrollingUp) {
      if (_isScrollingDown != false) {
        setState(() {
          _isScrollingDown = false;
        });
      }
    }
    
    _lastScrollPosition = currentPosition;
    
    // Show blur when actively scrolling (not at edges)
    if ((isScrollingDown && !isAtTop) || (isScrollingUp && !isAtBottom)) {
      if (!_isScrolling) {
        setState(() {
          _isScrolling = true;
        });
        _controller.forward();
      }
    } else {
      // Hide blur when at edges or not scrolling
      if (_isScrolling) {
        setState(() {
          _isScrolling = false;
        });
        _controller.reverse();
      }
    }

    // Reset timer for scroll end detection
    _scrollTimer?.cancel();
    _scrollTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted && _isScrolling) {
        _isScrolling = false;
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        
      
        // Top blur overlay (when scrolling down)
        if (_isScrolling && _isScrollingDown)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _blurAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _blurAnimation.value,
                  child: Container(
                    height: widget.blurHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.95),
                          Colors.black.withValues(alpha: 0.8),
                          Colors.black.withValues(alpha: 0.5),
                          Colors.black.withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.3, 0.6, 0.8, 1.0],
                      ),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 25.0 * _blurAnimation.value,
                          sigmaY: 25.0 * _blurAnimation.value,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.7 * _blurAnimation.value),
                                Colors.black.withValues(alpha: 0.4 * _blurAnimation.value),
                                Colors.black.withValues(alpha: 0.2 * _blurAnimation.value),
                                Colors.transparent,
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.4, 0.7, 0.9, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        
        // Bottom blur overlay (when scrolling up)
        if (_isScrolling && !_isScrollingDown)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _blurAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _blurAnimation.value,
                  child: Container(
                    height: widget.blurHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                           Colors.black.withValues(alpha: 0.7 * _blurAnimation.value),
                                Colors.black.withValues(alpha: 0.4 * _blurAnimation.value),
                                Colors.black.withValues(alpha: 0.2 * _blurAnimation.value),
                                Colors.transparent,
                                Colors.transparent,
                        ],
                         stops: const [0.0, 0.4, 0.7, 0.9, 1.0],
                      ),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 25.0 * _blurAnimation.value,
                          sigmaY: 25.0 * _blurAnimation.value,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.7 * _blurAnimation.value),
                                Colors.black.withValues(alpha: 0.4 * _blurAnimation.value),
                                Colors.black.withValues(alpha: 0.2 * _blurAnimation.value),
                                Colors.black.withValues(alpha: 0.05 * _blurAnimation.value),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.4, 0.7, 0.9, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
