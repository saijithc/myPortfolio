import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

  // Section keys for scroll-to-section
  final GlobalKey _headerKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _caseStudiesKey = GlobalKey();
  final GlobalKey _whyHireKey = GlobalKey();
  final GlobalKey _hobbiesKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // Contact form
  final GlobalKey<FormState> _contactFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSubmittingContact = false;

  // Scroll controller for smooth scrolling
  final ScrollController _scrollController = ScrollController();

  String _activeSection = 'Home';
  String _lastCommandFeedback = '';

  PortfolioViewModel() {
    _scrollController.addListener(_onScroll);
  }

  String get lastCommandFeedback => _lastCommandFeedback;

  String processCommand(String cmd) {
    final lower = cmd.toLowerCase().trim();

    switch (lower) {
      case 'help':
        _lastCommandFeedback = _getHelpText();
        return _lastCommandFeedback;

      case 'about':
        _scrollToKey(_aboutKey);
        _lastCommandFeedback = 'Navigating to About section...';
        return _lastCommandFeedback;

      case 'skills':
        _scrollToKey(_skillsKey);
        _lastCommandFeedback = 'Navigating to Skills section...';
        return _lastCommandFeedback;

      case 'services':
        _scrollToKey(_servicesKey);
        _lastCommandFeedback = 'Navigating to Services section...';
        return _lastCommandFeedback;

      case 'experience':
      case 'exp':
        _scrollToKey(_experienceKey);
        _lastCommandFeedback = 'Navigating to Experience section...';
        return _lastCommandFeedback;

      case 'projects':
      case 'proj':
        _scrollToKey(_projectsKey);
        _lastCommandFeedback = 'Navigating to Projects section...';
        return _lastCommandFeedback;

      case 'hobbies':
        _scrollToKey(_hobbiesKey);
        _lastCommandFeedback = 'Navigating to Hobbies section...';
        return _lastCommandFeedback;

      case 'home':
        _scrollToKey(_headerKey);
        _lastCommandFeedback = 'Navigating to Home section...';
        return _lastCommandFeedback;

      case 'whyhire':
        _scrollToKey(_whyHireKey);
        _lastCommandFeedback = 'Navigating to Why Hire Me section...';
        return _lastCommandFeedback;

      case 'contact':
        _lastCommandFeedback = 'saijith053@gmail.com | ${contactInfo.phone}';
        return _lastCommandFeedback;

      case 'github':
        _launchUrl('https://${contactInfo.github}');
        _lastCommandFeedback = 'Opening GitHub profile...';
        return _lastCommandFeedback;

      case 'linkedin':
        _launchUrl('https://${contactInfo.linkedin}');
        _lastCommandFeedback = 'Opening LinkedIn profile...';
        return _lastCommandFeedback;

      case 'email':
        _launchUrl('mailto:${contactInfo.email}');
        _lastCommandFeedback = 'Opening mail client...';
        return _lastCommandFeedback;

      case 'whoami':
        _lastCommandFeedback =
            '${contactInfo.name} | Flutter Developer | ${contactInfo.location}';
        return _lastCommandFeedback;

      case 'ls':
        _lastCommandFeedback = _listSections();
        return _lastCommandFeedback;

      case 'clear':
        _lastCommandFeedback = '';
        return '';

      case 'resume':
        _lastCommandFeedback = 'Resume download initiated (if available)';
        return _lastCommandFeedback;

      default:
        _lastCommandFeedback =
            'Command not found: $cmd. Type "help" for available commands.';
        return _lastCommandFeedback;
    }
  }

  String _getHelpText() {
    return [
      'Available commands:',
      '  about       - About me section',
      '  skills      - Skills & expertise',
      '  services    - Services I offer',
      '  experience  - Work experience',
      '  projects    - Featured projects',
      '  hobbies     - My hobbies',
      '  whoami      - Quick intro',
      '  contact     - Contact info',
      '  github      - Open GitHub',
      '  linkedin    - Open LinkedIn',
      '  email       - Send email',
      '  resume      - Download resume',
      '  ls          - List all sections',
      '  home        - Scroll to top',
      '  clear       - Clear terminal',
      '  help        - Show this help',
    ].join('\n');
  }

  String _listSections() {
    return [
      'home/',
      'about/',
      'skills/',
      'services/',
      'experience/',
      'projects/',
      'hobbies/',
      'whyhire/',
    ].join('  ');
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderObject = context.findRenderObject();
      if (renderObject != null && renderObject.attached) {
        try {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubic,
            alignment: 0.06,
          );
        } catch (_) {}
      }
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final sections = {
      'Home': _headerKey,
      'About Me': _aboutKey,
      'Skills': _skillsKey,
      'Services': _servicesKey,
      'Experience': _experienceKey,
    };

    double minDistance = double.infinity;
    String closestSection = _activeSection;

    for (final entry in sections.entries) {
      final context = entry.value.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero).dy;
          final distance = (position - 250).abs();
          if (distance < minDistance && position < 600) {
            minDistance = distance;
            closestSection = entry.key;
          }
        }
      }
    }

    if (closestSection != _activeSection) {
      _activeSection = closestSection;
      notifyListeners();
    }
  }

  // Getters
  int get currentSection => _currentSection;
  String get activeSection => _activeSection;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  GlobalKey<FormState> get contactFormKey => _contactFormKey;
  ScrollController get scrollController => _scrollController;
  GlobalKey get headerKey => _headerKey;
  GlobalKey get aboutKey => _aboutKey;
  GlobalKey get achievementsKey => _achievementsKey;
  GlobalKey get skillsKey => _skillsKey;
  GlobalKey get servicesKey => _servicesKey;
  GlobalKey get experienceKey => _experienceKey;
  GlobalKey get projectsKey => _projectsKey;
  GlobalKey get caseStudiesKey => _caseStudiesKey;
  GlobalKey get whyHireKey => _whyHireKey;
  GlobalKey get hobbiesKey => _hobbiesKey;
  GlobalKey get pricingKey => _pricingKey;
  GlobalKey get contactKey => _contactKey;

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
      await Future.delayed(const Duration(seconds: 2));
      _clearContactForm();
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

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
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
