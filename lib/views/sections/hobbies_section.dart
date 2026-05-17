import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../hobbies_page.dart';

class HobbiesSection extends StatelessWidget {
  const HobbiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: context.theme.secondaryDark.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.theme.neonGreen.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                Text(
                  r'$ cat hobbies.txt',
                  style: context.theme.terminalText.copyWith(
                    color: context.theme.textSecondary,
                    fontSize: isMobile ? 13 : 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Things I love to do in my free time',
                  style: context.theme.terminalText.copyWith(
                    color: context.theme.neonGreen,
                    fontSize: isMobile ? 16 : 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _HobbyGrid(isMobile: isMobile),
          const SizedBox(height: 40),
          _ViewAllButton(isMobile: isMobile),
        ],
      ),
    );
  }
}

class _HobbyGrid extends StatelessWidget {
  final bool isMobile;
  const _HobbyGrid({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final hobbies = [
      _HobbyData(icon: Icons.directions_bike, label: 'Cycling'),
      _HobbyData(icon: Icons.music_note, label: 'Music'),
      _HobbyData(icon: Icons.terrain, label: 'Trekking'),
      _HobbyData(icon: Icons.camera_alt, label: 'Photography'),
      _HobbyData(icon: Icons.menu_book, label: 'Reading'),
      _HobbyData(icon: Icons.fitness_center, label: 'Fitness'),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: hobbies.map((hobby) {
        return _HobbyCard(hobby: hobby, isMobile: isMobile);
      }).toList(),
    );
  }
}

class _HobbyCard extends StatefulWidget {
  final _HobbyData hobby;
  final bool isMobile;

  const _HobbyCard({required this.hobby, required this.isMobile});

  @override
  State<_HobbyCard> createState() => _HobbyCardState();
}

class _HobbyCardState extends State<_HobbyCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.isMobile ? 90.0 : 110.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _isHovered
              ? AppTheme.neonGreen.withValues(alpha: 0.08)
              : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppTheme.neonGreen
                : AppTheme.neonGreen.withValues(alpha: 0.2),
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.neonGreen.withValues(alpha: 0.12),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.hobby.icon,
              size: widget.isMobile ? 28 : 34,
              color: _isHovered ? AppTheme.neonGreen : AppTheme.textSecondary,
            ),
            const SizedBox(height: 6),
            Text(
              widget.hobby.label,
              style: GoogleFonts.jetBrainsMono(
                fontSize: widget.isMobile ? 9 : 10,
                color: _isHovered ? AppTheme.neonGreen : AppTheme.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewAllButton extends StatefulWidget {
  final bool isMobile;
  const _ViewAllButton({required this.isMobile});

  @override
  State<_ViewAllButton> createState() => _ViewAllButtonState();
}

class _ViewAllButtonState extends State<_ViewAllButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const HobbiesPage()));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 28 : 40,
            vertical: widget.isMobile ? 12 : 14,
          ),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.neonGreen.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.neonGreen
                  : AppTheme.neonGreen.withValues(alpha: 0.4),
              width: _isHovered ? 1.5 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.neonGreen.withValues(alpha: 0.15),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                r'$ ./view_all --hobbies',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: widget.isMobile ? 12 : 13,
                  color: _isHovered
                      ? AppTheme.neonGreen
                      : AppTheme.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: widget.isMobile ? 14 : 16,
                color: _isHovered ? AppTheme.neonGreen : AppTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HobbyData {
  final IconData icon;
  final String label;

  _HobbyData({required this.icon, required this.label});
}
