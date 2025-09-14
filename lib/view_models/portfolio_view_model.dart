import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/contact_info.dart';
import '../models/skill.dart';
import '../models/project.dart';
import '../models/experience.dart';
import '../models/service.dart';
import '../models/pricing_plan.dart';
import '../models/achievement.dart';

class PortfolioViewModel extends ChangeNotifier {
  // Navigation
  int _currentSection = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Contact form
  final GlobalKey<FormState> _contactFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSubmittingContact = false;

  // Scroll controller for smooth scrolling
  final ScrollController _scrollController = ScrollController();

  // Getters
  int get currentSection => _currentSection;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  GlobalKey<FormState> get contactFormKey => _contactFormKey;
  ScrollController get scrollController => _scrollController;
  
  // Contact form getters
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get messageController => _messageController;
  bool get isSubmittingContact => _isSubmittingContact;

  // Data getters
  ContactInfo get contactInfo => AppConstants.contactInfo;
  List<Skill> get skills => AppConstants.skills;
  List<Project> get projects => AppConstants.projects;
  List<Experience> get experiences => AppConstants.experiences;
  List<Service> get services => AppConstants.services;
  List<PricingPlan> get pricingPlans => AppConstants.pricingPlans;
  List<Achievement> get achievements => AppConstants.achievements;

  // Navigation methods
  void setCurrentSection(int section) {
    _currentSection = section;
    notifyListeners();
  }

  void scrollToSection(int sectionIndex) {
    // This will be implemented with scroll controllers
    setCurrentSection(sectionIndex);
  }

  void toggleDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  // Contact form methods
  void submitContactForm() async {
    if (!_contactFormKey.currentState!.validate()) {
      return;
    }

    _isSubmittingContact = true;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Here you would typically send the form data to your backend
      // For now, we'll just show a success message
      
      _clearContactForm();
      
      // Show success message (you can implement a snackbar or dialog)
      debugPrint('Contact form submitted successfully');
      
    } catch (e) {
      debugPrint('Error submitting contact form: $e');
    } finally {
      _isSubmittingContact = false;
      notifyListeners();
    }
  }

  void _clearContactForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  // Validation methods
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your message';
    }
    if (value.length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }

  // Filter methods for categorized data
  List<Skill> getSkillsByCategory(String category) {
    return skills.where((skill) => skill.category == category).toList();
  }

  List<String> get skillCategories {
    return skills.map((skill) => skill.category).toSet().toList();
  }

  // Animation triggers
  bool _shouldAnimate = true;
  bool get shouldAnimate => _shouldAnimate;

  void setShouldAnimate(bool value) {
    _shouldAnimate = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
