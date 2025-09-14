import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/portfolio_view_model.dart';
import '../widgets/fade_in_widget.dart';
import 'sections/header_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/services_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/why_hire_section.dart';
import 'sections/pricing_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

class PortfolioHomePage extends StatelessWidget {
  const PortfolioHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          key: viewModel.scaffoldKey,
          body: Container(
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
                  FadeInWidget(
                    delay: const Duration(milliseconds: 200),
                    child: HeaderSection(scrollController: viewModel.scrollController),
                  ),
                  
                  // About Section
                  FadeInWidget(
                    delay: const Duration(milliseconds: 400),
                    child: const AboutSection(),
                  ),
                  
                  // Skills Section
                  FadeInWidget(
                    delay: const Duration(milliseconds: 600),
                    child: const SkillsSection(),
                  ),
                  
                  // Services Section
                  FadeInWidget(
                    delay: const Duration(milliseconds: 800),
                    child: const ServicesSection(),
                  ),
                  
                  // Experience Section
                  FadeInWidget(
                    delay: const Duration(milliseconds: 1000),
                    child: const ExperienceSection(),
                  ),
                  
                  // Projects Section
                  FadeInWidget(
                    delay: const Duration(milliseconds: 1200),
                    child: const ProjectsSection(),
                  ),
                  
                  // Why Hire Me Section
                  FadeInWidget(
                    delay: const Duration(milliseconds: 1400),
                    child: const WhyHireSection(),
                  ),
                  
                  // Pricing Section
                  // FadeInWidget(
                  //   delay: const Duration(milliseconds: 1600),
                  //   child: const PricingSection(),
                  // ),
                  
                  // Contact Section
                  // FadeInWidget(
                  //   delay: const Duration(milliseconds: 1800),
                  //   child: const ContactSection(),
                  // ),
                  
                  // Footer Section
                  FadeInWidget(
                    delay: const Duration(milliseconds: 2000),
                    child: const FooterSection(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
