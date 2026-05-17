import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class ModernNavBar extends StatefulWidget {
  final void Function(int) onItemSelected;
  final int activeIndex;

  const ModernNavBar({
    super.key,
    required this.onItemSelected,
    this.activeIndex = 0,
  });

  @override
  State<ModernNavBar> createState() => _ModernNavBarState();
}

class _ModernNavBarState extends State<ModernNavBar> {
  final _items = const [
    _NavItemData(icon: Icons.home, label: 'HOME'),
    _NavItemData(icon: Icons.person, label: 'ABOUT'),
    _NavItemData(icon: Icons.terminal, label: 'SKILLS'),
    _NavItemData(icon: Icons.design_services, label: 'SERVICES'),
    _NavItemData(icon: Icons.work_history, label: 'WORK'),
    _NavItemData(icon: Icons.folder, label: 'PROJECTS'),
    _NavItemData(icon: Icons.alternate_email, label: 'HIRE'),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 16 : 24),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHighest.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppTheme.primaryContainer.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryContainer.withValues(alpha: 0.2),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isActive = widget.activeIndex == index;
          final isHire = item.label == 'HIRE';
          return GestureDetector(
            onTap: () => widget.onItemSelected(index),
            child: AnimatedContainer(
              duration: AppTheme.fastAnimation,
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: EdgeInsets.all(isMobile ? 10 : 12),
              decoration: BoxDecoration(
                color: isActive
                    ? (isHire ? AppTheme.secondaryContainer : AppTheme.primaryContainer)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                item.icon,
                size: isMobile ? 20 : 22,
                color: isActive
                    ? (isHire ? AppTheme.onSecondaryContainer : AppTheme.onPrimaryContainer)
                    : AppTheme.onSurfaceVariant,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;
  const _NavItemData({required this.icon, required this.label});
}
