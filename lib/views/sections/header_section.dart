import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import '../../widgets/typing_animation.dart';

class HeaderSection extends StatelessWidget {
  final ScrollController scrollController;

  const HeaderSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 800),
      child: Stack(
        children: [
          // Theme Switcher at Top Right
          Positioned(
            top: 20,
            right: isMobile ? 20 : 40,
            child: _buildThemeSwitcher(context),
          ),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 40,
                  vertical: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Terminal Boot Sequence
                    const _BootSequence(),

                    const SizedBox(height: 40),

                    // Circular Profile Image
                    Container(
                          width: isMobile ? 150 : 180,
                          height: isMobile ? 150 : 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: context.theme.neonGreen,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: context.theme.neonGreen.withValues(
                                  alpha: 0.4,
                                ),
                                blurRadius: 40,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/profile_image.png',
                              fit: BoxFit.cover,
                              cacheWidth: 360,
                              cacheHeight: 360,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 80,
                                  color: context.theme.neonGreen,
                                );
                              },
                            ),
                          ),
                        )
                        .animate()
                        .scale(duration: 800.ms, curve: Curves.easeOutBack)
                        .fadeIn(),

                    const SizedBox(height: 40),

                    // Main Tagline
                    Text(
                          "Hi, I'm Saijith C.",
                          style: context.theme.headingLarge.copyWith(
                            fontSize: isMobile ? 36 : 56,
                            shadows: [
                              Shadow(
                                color: context.theme.neonGreen.withValues(
                                  alpha: 0.5,
                                ),
                                blurRadius: 20,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .slideY(
                          begin: 0.5,
                          end: 0,
                          duration: 600.ms,
                          delay: 300.ms,
                        )
                        .fadeIn(),

                    const SizedBox(height: 16),

                    // Animated Subtitle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TypingAnimation(
                          text: "> Flutter Developer",
                          textStyle: context.theme.terminalText.copyWith(
                            fontSize: isMobile ? 18 : 24,
                            shadows: [
                              Shadow(
                                color: context.theme.neonGreen,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        _BlinkingCursor(),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Social Links
                    _SocialLinks(
                      isMobile: isMobile,
                    ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),

                    const SizedBox(height: 60),

                    // Scroll Down Indicator
                    _ScrollDownIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSwitcher(BuildContext context) {
    return ThemeSwitcher.withTheme(
      builder: (_, switcher, theme) {
        final isLight = theme.brightness == Brightness.light;
        return IconButton(
          icon: Icon(
            isLight ? Icons.dark_mode : Icons.light_mode,
            color: context.theme.neonGreen,
          ),
          onPressed: () {
            switcher.changeTheme(
              theme: isLight ? AppTheme.darkTheme : AppTheme.lightTheme,
            );
          },
        );
      },
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  @override
  _BlinkingCursorState createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Text(
        "_",
        style: context.theme.terminalText.copyWith(
          fontSize: ResponsiveBreakpoints.of(context).isMobile ? 18 : 24,
        ),
      ),
    );
  }
}

class _BootSequence extends StatefulWidget {
  const _BootSequence();

  @override
  _BootSequenceState createState() => _BootSequenceState();
}

class _BootSequenceState extends State<_BootSequence>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _visibleLines = 0;

  final _lines = [
    '> systemctl --user start portfolio.service',
    '[  OK  ] Loaded profile: guest@saijithc',
    '> Initializing environment... [COMPLETE]',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _showNextLine();
  }

  void _showNextLine() {
    if (!mounted) return;
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() {
        if (_visibleLines < _lines.length) {
          _visibleLines++;
          _controller.reset();
          _controller.forward();
          _showNextLine();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_lines.length, (index) {
        if (index >= _visibleLines) return const SizedBox.shrink();
        return Padding(
          padding: EdgeInsets.only(bottom: isMobile ? 2 : 4),
          child: FadeTransition(
            opacity: _controller,
            child: Text(
              _lines[index],
              style: context.theme.terminalText.copyWith(
                fontSize: isMobile ? 10 : 12,
                color: index == 1
                    ? context.theme.neonGreen
                    : context.theme.textTertiary,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _SocialLinks extends StatelessWidget {
  final bool isMobile;
  const _SocialLinks({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final links = [
      {
        'label': 'E-MAIL',
        'action': () => _openUrl('mailto:${AppConstants.contactInfo.email}'),
      },
      {
        'label': 'GITHUB',
        'action': () => _openUrl('https://${AppConstants.contactInfo.github}'),
      },
      {
        'label': 'LINKEDIN',
        'action': () =>
            _openUrl('https://${AppConstants.contactInfo.linkedin}'),
      },
      if (AppConstants.contactInfo.instagram != null)
        {
          'label': 'INSTAGRAM',
          'action': () =>
              _openUrl('https://${AppConstants.contactInfo.instagram}'),
        },
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 16,
      children: List.generate(links.length * 2 - 1, (index) {
        if (index.isOdd) {
          return Text(
            "/",
            style: context.theme.terminalText.copyWith(
              color: context.theme.neonGreen.withValues(alpha: 0.5),
            ),
          );
        }
        final linkIndex = index ~/ 2;
        final link = links[linkIndex];
        return _HoverLink(
          label: link['label'] as String,
          onTap: link['action'] as VoidCallback,
        );
      }),
    );
  }

  Future<void> _openUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}

class _HoverLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _HoverLink({required this.label, required this.onTap});

  @override
  __HoverLinkState createState() => __HoverLinkState();
}

class __HoverLinkState extends State<_HoverLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: context.theme.terminalText.copyWith(
            color: isHovered
                ? context.theme.textPrimary
                : context.theme.textSecondary,
            shadows: isHovered
                ? [Shadow(color: context.theme.neonGreen, blurRadius: 10)]
                : null,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _ScrollDownIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: context.theme.neonGreen.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: context.theme.neonGreen.withValues(alpha: 0.2),
                blurRadius: 15,
              ),
            ],
          ),
          child: Icon(
            Icons.keyboard_arrow_down,
            color: context.theme.neonGreen,
            size: 30,
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(begin: -5, end: 5, duration: 1.seconds, curve: Curves.easeInOut);
  }
}
