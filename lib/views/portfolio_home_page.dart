import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/portfolio_view_model.dart';
import '../widgets/scroll_triggered_loading_widget.dart';
import '../widgets/scroll_blur_overlay.dart';
import 'sections/header_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/services_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/why_hire_section.dart';
import 'sections/footer_section.dart';

class PortfolioHomePage extends StatelessWidget {
  const PortfolioHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          key: viewModel.scaffoldKey,
          body: ScrollBlurOverlay(
            scrollController: viewModel.scrollController,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0A0A0A),
                    Color(0xFF1A1A1A),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                controller: viewModel.scrollController,
                child: Column(
                  children: [
                  // Header Section
                  ScrollTriggeredLoadingWidget(
                    key: viewModel.headerKey,
                    child: HeaderSection(
                      key: viewModel.headerKey,
                      scrollController: viewModel.scrollController,
                    ),
                  ),
                  
                  // About Section
                  ScrollTriggeredLoadingWidget(
                    key: viewModel.aboutKey,
                    child: const AboutSection(),
                  ),
                  
                  // Skills Section
                  ScrollTriggeredLoadingWidget(
                    key: viewModel.skillsKey,
                    child: const SkillsSection(),
                  ),
                  
                  // Services Section
                  ScrollTriggeredLoadingWidget(
                    key: viewModel.servicesKey,
                    child: const ServicesSection(),
                  ),
                  
                  // Experience Section
                  ScrollTriggeredLoadingWidget(
                    key: viewModel.experienceKey,
                    child: const ExperienceSection(),
                  ),
                  
                  // Projects Section
                  ScrollTriggeredLoadingWidget(
                    key: viewModel.projectsKey,
                    child: const ProjectsSection(),
                  ),
                  
                  // Why Hire Me Section
                  ScrollTriggeredLoadingWidget(
                    key: viewModel.whyHireKey,
                    child: const WhyHireSection(),
                  ),
                  
                  // Pricing Section
                  // ScrollTriggeredLoadingWidget(
                  //   key: viewModel.pricingKey,
                  //   child: const PricingSection(),
                  // ),
                  
                  // Contact Section
                  // ScrollTriggeredLoadingWidget(
                  //   key: viewModel.contactKey,
                  //   child: const ContactSection(),
                  // ),
                  
                  // Footer Section
                  ScrollTriggeredLoadingWidget(
                    child: const FooterSection(),
                  ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
