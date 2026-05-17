import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/portfolio_view_model.dart';
import '../widgets/scroll_triggered_loading_widget.dart';
import '../widgets/terminal_shell.dart';
import '../widgets/cyberpunk_background.dart';
import '../widgets/floating_nav_bar.dart';
import '../widgets/mouse_glow.dart';
import 'sections/header_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/services_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/why_hire_section.dart';
import 'sections/hobbies_section.dart';
import 'sections/footer_section.dart';

class PortfolioHomePage extends StatelessWidget {
  const PortfolioHomePage({super.key});

  void _scrollToSection(BuildContext context, String sectionName) {
    final viewModel = Provider.of<PortfolioViewModel>(context, listen: false);

    GlobalKey? key;
    switch (sectionName.toLowerCase()) {
      case 'home':
        key = viewModel.headerKey;
        break;
      case 'about me':
        key = viewModel.aboutKey;
        break;
      case 'skills':
        key = viewModel.skillsKey;
        break;
      case 'services':
        key = viewModel.servicesKey;
        break;
      case 'experience':
        key = viewModel.experienceKey;
        break;
      case 'projects':
      case 'case studies':
        key = viewModel.projectsKey;
        break;
      case 'hobbies':
        key = viewModel.hobbiesKey;
        break;
      case 'contact':
        key = viewModel.contactKey;
        break;
    }

    final targetContext = key?.currentContext;
    if (targetContext == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderObject = targetContext.findRenderObject();
      if (renderObject != null && renderObject.attached) {
        try {
          Scrollable.ensureVisible(
            targetContext,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
            alignment: 0.08,
          );
        } catch (_) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          key: viewModel.scaffoldKey,
          body: MouseGlow(
            child: Stack(
              children: [
                const CyberpunkBackground(),
                TerminalShell(
                  scrollController: viewModel.scrollController,
                  child: SingleChildScrollView(
                    controller: viewModel.scrollController,
                    child: Column(
                      children: [
                        ScrollTriggeredLoadingWidget(
                          key: viewModel.headerKey,
                          child: HeaderSection(
                            scrollController: viewModel.scrollController,
                          ),
                        ),
                        ScrollTriggeredLoadingWidget(
                          key: viewModel.aboutKey,
                          child: const AboutSection(),
                        ),
                        ScrollTriggeredLoadingWidget(
                          key: viewModel.skillsKey,
                          child: const SkillsSection(),
                        ),
                        ScrollTriggeredLoadingWidget(
                          key: viewModel.servicesKey,
                          child: const ServicesSection(),
                        ),
                        ScrollTriggeredLoadingWidget(
                          key: viewModel.experienceKey,
                          child: const ExperienceSection(),
                        ),
                        ScrollTriggeredLoadingWidget(
                          key: viewModel.projectsKey,
                          child: const ProjectsSection(),
                        ),
                        ScrollTriggeredLoadingWidget(
                          key: viewModel.whyHireKey,
                          child: const WhyHireSection(),
                        ),
                        ScrollTriggeredLoadingWidget(
                          key: viewModel.hobbiesKey,
                          child: const HobbiesSection(),
                        ),
                        ScrollTriggeredLoadingWidget(
                          child: const FooterSection(),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FloatingNavBar(
                      activeItem: viewModel.activeSection,
                      onNavItemSelected: (section) =>
                          _scrollToSection(context, section),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
