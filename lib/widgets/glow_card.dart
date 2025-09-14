import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class GlowCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final bool isGlowing;

  const GlowCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.isGlowing = false,
  });

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppTheme.normalAnimation,
      vsync: this,
    );
    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: AppTheme.defaultCurve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          final glowIntensity = _isHovered ? _glowAnimation.value : 0.0;
          final borderOpacity = widget.isGlowing ? 0.5 : 0.1 + (glowIntensity * 0.4);
          final shadowOpacity = widget.isGlowing ? 0.3 : 0.05 + (glowIntensity * 0.25);

          return Container(
            width: widget.width,
            height: widget.height,
            margin: widget.margin,
            decoration: BoxDecoration(
              gradient: AppTheme.cardGradient,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.neonGreen.withOpacity(borderOpacity),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.neonGreen.withOpacity(shadowOpacity),
                  blurRadius: 20 + (glowIntensity * 20),
                  offset: Offset(0, 8 + (glowIntensity * 8)),
                ),
                BoxShadow(
                  color: AppTheme.neonGreen.withOpacity(shadowOpacity * 0.5),
                  blurRadius: 40 + (glowIntensity * 40),
                  offset: Offset(0, 16 + (glowIntensity * 16)),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: widget.padding ?? const EdgeInsets.all(20),
                  child: widget.child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
