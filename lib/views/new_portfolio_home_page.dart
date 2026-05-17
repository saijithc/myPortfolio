import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../widgets/modern_nav_bar.dart';
import '../widgets/mouse_glow.dart';
import 'new_sections/new_header_section.dart';
import 'new_sections/new_about_section.dart';
import 'new_sections/new_skills_section.dart';
import 'new_sections/new_services_section.dart';
import 'new_sections/new_experience_section.dart';
import 'new_sections/new_projects_section.dart';
import 'new_sections/new_achievements_section.dart';
import 'new_sections/new_hobbies_section.dart';
import 'new_sections/new_contact_section.dart';
import 'new_sections/new_footer_section.dart';

class NewPortfolioHomePage extends StatefulWidget {
  const NewPortfolioHomePage({super.key});

  @override
  State<NewPortfolioHomePage> createState() => _NewPortfolioHomePageState();
}

class _NewPortfolioHomePageState extends State<NewPortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  int _activeSection = 0;
  int _lastScrollCheck = 0;

  static const int _sectionCount = 10;
  final _sectionKeys = List.generate(_sectionCount, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollThrottled);
  }

  void _onScrollThrottled() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastScrollCheck < 100) return;
    _lastScrollCheck = now;
    _onScroll();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    for (int i = 0; i < _sectionCount; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final renderBox = ctx.findRenderObject() as RenderBox?;
      if (renderBox == null) continue;
      final position = renderBox.localToGlobal(Offset.zero).dy;
      if (position < 300 && position > -200) {
        if (_activeSection != i) setState(() => _activeSection = i);
        break;
      }
    }
  }

  final _navToSection = [0, 1, 3, 4, 5, 6, 8];

  void _scrollToSection(int index) {
    if (index < 0 || index >= _navToSection.length) return;
    final section = _navToSection[index];
    if (section >= _sectionCount) return;
    final context = _sectionKeys[section].currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.06,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      body: MouseGlow(
        child: Stack(
        children: [
          RepaintBoundary(
            child: CustomPaint(
              size: size,
              painter: _DotGridPainter(),
            ),
          ),
          RepaintBoundary(
            child: IgnorePointer(
              child: CustomPaint(
                size: size,
                painter: _ScanlinePainter(),
              ),
            ),
          ),
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.overlay,
                color: Colors.transparent,
              ),
              child: Opacity(
                opacity: 0.03,
                child: Image.asset(
                  'assets/images/noise.png',
                  repeat: ImageRepeat.repeat,
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                  cacheWidth: 512,
                  cacheHeight: 512,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Sticky top bar - FLUTTER_DEV_OS
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 16 : 64,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.surface.withValues(alpha: 0.9),
                    border: Border(
                      bottom: BorderSide(
                        color: AppTheme.primaryContainer.withValues(alpha: 0.1),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryContainer.withValues(alpha: 0.1),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.terminal_rounded,
                        size: 20,
                        color: AppTheme.primaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'FLUTTER_DEV_OS',
                        style: AppTheme.codeMedium.copyWith(
                          fontSize: 16,
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                RepaintBoundary(
                  child: SizedBox(
                    key: _sectionKeys[0],
                    child: NewHeaderSection(
                      onConnectTap: () => _scrollToSection(6),
                    ),
                  ),
                ),
                RepaintBoundary(child: SizedBox(key: _sectionKeys[1], child: const NewAboutSection())),
                RepaintBoundary(child: SizedBox(key: _sectionKeys[2], child: const NewAchievementsSection())),
                RepaintBoundary(child: SizedBox(key: _sectionKeys[3], child: const NewSkillsSection())),
                RepaintBoundary(child: SizedBox(key: _sectionKeys[4], child: const NewServicesSection())),
                RepaintBoundary(child: SizedBox(key: _sectionKeys[5], child: const NewExperienceSection())),
                RepaintBoundary(child: SizedBox(key: _sectionKeys[6], child: const NewProjectsSection())),
                RepaintBoundary(child: SizedBox(key: _sectionKeys[7], child: const NewHobbiesSection())),
                RepaintBoundary(child: SizedBox(key: _sectionKeys[8], child: const NewContactSection())),
                RepaintBoundary(child: SizedBox(key: _sectionKeys[9], child: const NewFooterSection())),
                const SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: ModernNavBar(
                activeIndex: _activeSection,
                onItemSelected: _scrollToSection,
              ),
            ),
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
