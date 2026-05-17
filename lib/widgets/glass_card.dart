import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double borderRadius;
  final Color? borderColor;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.borderRadius = 16,
    this.borderColor,
    this.gradient,
    this.boxShadow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: width,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? const Color(0xFF1E1E2E),
          width: 1,
        ),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: card,
        ),
      );
    }

    return card;
  }
}
