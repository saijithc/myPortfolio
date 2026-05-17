import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../constants/app_theme.dart';
import '../../widgets/section_header.dart';
import '../hobbies_page.dart';

class NewHobbiesSection extends StatelessWidget {
  const NewHobbiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBreakpoints.of(context);
    final isMobile = bp.isMobile;
    final isTablet = bp.isTablet;
    final double horizontalPad = isMobile ? 16.0 : (isTablet ? 40.0 : 64.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPad,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TerminalHeader(command: 'cat hobbies.txt'),
          _HobbyGrid(isMobile: isMobile),
          const SizedBox(height: 32),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HobbiesPage())),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 32, vertical: isMobile ? 10 : 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.5)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('VIEW_ALL_HOBBIES', style: AppTheme.codeMedium.copyWith(fontSize: 11, color: AppTheme.primaryContainer)),
              ),
            ),
          ),
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
      _HobbyData(Icons.directions_bike, 'Cycling'),
      _HobbyData(Icons.music_note, 'Music'),
      _HobbyData(Icons.terrain, 'Trekking'),
      _HobbyData(Icons.camera_alt, 'Photo'),
      _HobbyData(Icons.menu_book, 'Reading'),
      _HobbyData(Icons.fitness_center, 'Fitness'),
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Wrap(
        spacing: isMobile ? 12 : 16,
        runSpacing: isMobile ? 12 : 16,
        alignment: WrapAlignment.center,
        children: hobbies.map((h) => _HobbyItem(data: h, isMobile: isMobile)).toList(),
      ),
    );
  }
}

class _HobbyItem extends StatefulWidget {
  final _HobbyData data;
  final bool isMobile;
  const _HobbyItem({required this.data, required this.isMobile});

  @override
  State<_HobbyItem> createState() => _HobbyItemState();
}

class _HobbyItemState extends State<_HobbyItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTheme.normalAnimation,
        curve: Curves.easeOutCubic,
        width: widget.isMobile ? 130 : 150,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? AppTheme.primaryContainer.withValues(alpha: 0.5) : AppTheme.primaryContainer.withValues(alpha: 0.2),
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.08), blurRadius: 16)]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.data.icon, size: 28, color: _isHovered ? AppTheme.primaryContainer : AppTheme.onSurfaceVariant),
            const SizedBox(height: 10),
            Text(widget.data.label, style: AppTheme.codeMedium.copyWith(fontSize: 11, color: AppTheme.onSurfaceVariant, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _HobbyData {
  final IconData icon;
  final String label;
  _HobbyData(this.icon, this.label);
}
