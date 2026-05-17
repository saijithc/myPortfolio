import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_theme.dart';

class FloatingNavBar extends StatefulWidget {
  final void Function(String) onNavItemSelected;
  final String activeItem;

  const FloatingNavBar({
    super.key,
    required this.onNavItemSelected,
    this.activeItem = 'Home',
  });

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  String? hoveredItem;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 450;

    return Container(
          margin: EdgeInsets.only(bottom: isMobile ? 16 : 24),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 : 16,
            vertical: isMobile ? 6 : 10,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppTheme.neonGreen.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.neonGreen.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isActive: widget.activeItem == 'Home',
                  isHovered: hoveredItem == 'Home',
                  isMobile: isMobile,
                  onTap: () => widget.onNavItemSelected('Home'),
                  onHover: (v) =>
                      setState(() => hoveredItem = v ? 'Home' : null),
                ),
                _NavItem(
                  icon: Icons.person_rounded,
                  label: 'About',
                  isActive: widget.activeItem == 'About Me',
                  isHovered: hoveredItem == 'About',
                  isMobile: isMobile,
                  onTap: () => widget.onNavItemSelected('About Me'),
                  onHover: (v) =>
                      setState(() => hoveredItem = v ? 'About' : null),
                ),
                _NavItem(
                  icon: Icons.code_rounded,
                  label: 'Skills',
                  isActive: widget.activeItem == 'Skills',
                  isHovered: hoveredItem == 'Skills',
                  isMobile: isMobile,
                  onTap: () => widget.onNavItemSelected('Skills'),
                  onHover: (v) =>
                      setState(() => hoveredItem = v ? 'Skills' : null),
                ),
                _NavItem(
                  icon: Icons.design_services_rounded,
                  label: 'Services',
                  isActive: widget.activeItem == 'Services',
                  isHovered: hoveredItem == 'Services',
                  isMobile: isMobile,
                  onTap: () => widget.onNavItemSelected('Services'),
                  onHover: (v) =>
                      setState(() => hoveredItem = v ? 'Services' : null),
                ),
                _NavItem(
                  icon: Icons.work_rounded,
                  label: 'Exp',
                  isActive: widget.activeItem == 'Experience',
                  isHovered: hoveredItem == 'Exp',
                  isMobile: isMobile,
                  onTap: () => widget.onNavItemSelected('Experience'),
                  onHover: (v) =>
                      setState(() => hoveredItem = v ? 'Exp' : null),
                ),
              ],
            ),
          ),
        )
        .animate()
        .slideY(begin: 1, end: 0, duration: 600.ms, curve: Curves.easeOutCubic)
        .fadeIn();
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isHovered;
  final bool isMobile;
  final VoidCallback onTap;
  final void Function(bool) onHover;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isHovered,
    required this.isMobile,
    required this.onTap,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    final active = isActive || isHovered;

    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 10 : 14,
            vertical: isMobile ? 6 : 8,
          ),
          decoration: BoxDecoration(
            color: active
                ? AppTheme.neonGreen.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: isMobile ? 16 : 18,
                color: active ? AppTheme.neonGreen : AppTheme.textSecondary,
              ),
              if (!isMobile && active) ...[
                const SizedBox(width: 6),
                Text(
                  label,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    color: AppTheme.neonGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
