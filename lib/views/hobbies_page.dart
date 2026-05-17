import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../constants/app_theme.dart';
import '../models/hobby.dart';

class HobbiesPage extends StatefulWidget {
  const HobbiesPage({super.key});

  @override
  State<HobbiesPage> createState() => _HobbiesPageState();
}

class _HobbiesPageState extends State<HobbiesPage> {
  final List<Hobby> hobbies = [
    Hobby(
      name: 'Cycling',
      icon: Icons.directions_bike,
      description: 'Exploring new routes and staying active',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Music Discovery',
      icon: Icons.music_note,
      description: 'Finding new music and listening to them',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Hiking/Trekking',
      icon: Icons.terrain,
      description: 'Exploring nature and challenging trails',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Swimming',
      icon: Icons.pool,
      description: 'Staying fit and enjoying the water',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Drawing',
      icon: Icons.brush,
      description: 'Expressing creativity through art',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Photography',
      icon: Icons.camera_alt,
      description: 'Capturing moments and beauty',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Videography & Editing',
      icon: Icons.videocam,
      description: 'Creating and editing visual stories',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Reading',
      icon: Icons.menu_book,
      description: 'Exploring new worlds through books',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Watching Movies',
      icon: Icons.movie,
      description: 'Enjoying cinema and storytelling',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Football',
      icon: Icons.sports_soccer,
      description: 'Playing and following the beautiful game',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Cricket',
      icon: Icons.sports_cricket,
      description: 'Playing and watching cricket',
      color: AppTheme.primaryContainer,
    ),
    Hobby(
      name: 'Gym',
      icon: Icons.fitness_center,
      description: 'Building strength and maintaining fitness',
      color: AppTheme.primaryContainer,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(size: size, painter: _DotGridPainter()),
          IgnorePointer(
            child: CustomPaint(size: size, painter: _ScanlinePainter()),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : (isTablet ? 40 : 64),
                vertical: isMobile ? 16 : 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 32),
                  Text(
                    '\$ cat hobbies.txt',
                    style: AppTheme.terminalHeader,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'MY_HOBBIES',
                      style: AppTheme.headingDisplay.copyWith(
                        fontSize: isMobile ? 28 : 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Things I love to do in my free time',
                      style: AppTheme.codeMedium.copyWith(
                        fontSize: isMobile ? 11 : 13,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  _buildHobbiesGrid(isMobile, isTablet),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryContainer.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_rounded, size: 14, color: AppTheme.primaryContainer),
          ),
          const SizedBox(width: 8),
          Container(width: 1, height: 12, color: AppTheme.primaryContainer.withValues(alpha: 0.2)),
          const SizedBox(width: 8),
          Text(
            'hobbies.log',
            style: AppTheme.codeMedium.copyWith(fontSize: 10, color: AppTheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildHobbiesGrid(bool isMobile, bool isTablet) {
    final crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);
    final childAspectRatio = isMobile ? 0.85 : (isTablet ? 0.9 : 0.95);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isMobile ? 12 : 16,
            mainAxisSpacing: isMobile ? 12 : 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: hobbies.length,
          itemBuilder: (_, index) => _HobbyCard(hobby: hobbies[index], index: index),
        ),
      ),
    );
  }
}

class _HobbyCard extends StatefulWidget {
  final Hobby hobby;
  final int index;
  const _HobbyCard({required this.hobby, required this.index});

  @override
  State<_HobbyCard> createState() => _HobbyCardState();
}

class _HobbyCardState extends State<_HobbyCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final h = widget.hobby;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTheme.normalAnimation,
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? AppTheme.primaryContainer.withValues(alpha: 0.5)
                : AppTheme.primaryContainer.withValues(alpha: 0.2),
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: AppTheme.primaryContainer.withValues(alpha: 0.08), blurRadius: 16)]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isHovered
                      ? AppTheme.primaryContainer.withValues(alpha: 0.5)
                      : AppTheme.primaryContainer.withValues(alpha: 0.2),
                ),
              ),
              child: Icon(
                h.icon,
                size: 24,
                color: _isHovered ? AppTheme.primaryContainer : AppTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              h.name,
              style: AppTheme.codeMedium.copyWith(
                fontSize: 11,
                color: AppTheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              h.description,
              style: AppTheme.codeMedium.copyWith(fontSize: 9, color: AppTheme.onSurfaceVariant),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF1a1a1a);
    const spacing = 8.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 0.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x08000000)
      ..strokeWidth = 1;
    for (double y = 0; y < size.height; y += 3) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
