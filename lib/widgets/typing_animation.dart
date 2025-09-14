import 'package:flutter/material.dart';

class TypingAnimation extends StatefulWidget {
  final String text;
  final Duration duration;
  final TextStyle? textStyle;
  final Duration pauseDuration;

  const TypingAnimation({
    super.key,
    required this.text,
    this.duration = const Duration(milliseconds: 100),
    this.textStyle,
    this.pauseDuration = const Duration(milliseconds: 2000),
  });

  @override
  State<TypingAnimation> createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _displayText = '';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        if (_currentIndex < widget.text.length) {
          setState(() {
            _displayText += widget.text[_currentIndex];
            _currentIndex++;
          });
          _controller.reset();
          _controller.forward();
        } else {
          // Animation completed, wait for pause duration then restart
          Future.delayed(widget.pauseDuration, () {
            if (mounted) {
              setState(() {
                _displayText = '';
                _currentIndex = 0;
              });
              _controller.reset();
              _controller.forward();
            }
          });
        }
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.textStyle ?? Theme.of(context).textTheme.bodyLarge,
    );
  }
}
