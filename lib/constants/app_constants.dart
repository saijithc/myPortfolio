import '../models/skill.dart';
import '../models/project.dart';
import '../models/experience.dart';
import '../models/service.dart';
import '../models/pricing_plan.dart';
import '../models/achievement.dart';
import '../models/contact_info.dart';

class AppConstants {
  static const String appName = 'SAIJITH C';
  static const String tagline = 'Helping Businesses Achieve Higher Visibility';
  static const String subtitle = 'Frontend Developer (Flutter & Dart)';
  static const String aboutSummary = 
      'Flutter Developer with 3+ years of experience building robust mobile applications using Flutter and Dart. Specialized in Firebase integrations (Auth, Firestore, Messaging, Cloud Functions, Crashlytics, Analytics). Known for clean, modular, maintainable code with a focus on UI/UX and smooth user interactions.';

  static const ContactInfo contactInfo = ContactInfo(
    name: 'Saijith C',
    email: 'saijith053@gmail.com',
    phone: '+91 8139812226',
    location: 'Bangalore, India',
    github: 'github.com/saijithc',
    linkedin: 'linkedin.com/in/saijith-c-855495226',
  );

  static const List<String> navigationItems = [
    'Home',
    'About Me',
    'Achievements',
    'Skills',
    'Services',
    'Experience'
  ];

  static  List<Skill> skills = [
    // Frameworks & Languages
    Skill(name: 'Flutter', category: 'Framework', proficiency: 95, imagePath: 'assets/icons/flutter_logo.webp'),
    Skill(name: 'Dart', category: 'Language', proficiency: 90, imagePath: 'assets/icons/dart.webp'),
    
    // State Management
    Skill(name: 'Provider', category: 'State Management', proficiency: 90, imagePath: 'assets/icons/provider.jpg'),
    Skill(name: 'Riverpod', category: 'State Management', proficiency: 85, imagePath: 'assets/icons/riverpod.png'),
    Skill(name: 'GetX', category: 'State Management', proficiency: 85, imagePath: 'assets/icons/getx.png'),
    
    // Tools
    Skill(name: 'Firebase', category: 'Backend', proficiency: 90, imagePath: 'assets/icons/firebase.webp'),
    Skill(name: 'Hive', category: 'Database', proficiency: 90, imagePath: 'assets/icons/hive.png'),
    Skill(name: 'Figma', category: 'Design', proficiency: 75, imagePath: 'assets/icons/figma.webp'),
    Skill(name: 'Git', category: 'Version Control', proficiency: 100, imagePath: 'assets/icons/git.webp'),
    Skill(name: 'Postman', category: 'API Testing', proficiency: 80, imagePath: 'assets/icons/postman.webp'),
    
    // Architecture
    Skill(name: 'MVVM', category: 'Architecture', proficiency: 90, imagePath: 'assets/icons/mvvm.png'),
    Skill(name: 'MVC', category: 'Architecture', proficiency: 85, imagePath: 'assets/icons/mvc.jpg'),
    Skill(name: 'RESTful APIs', category: 'Integration', proficiency: 100, imagePath: 'assets/icons/rest-api.webp',shouldAddColor: true),
  ];

  static const List<Service> services = [
    Service(
      title: 'Mobile App Development',
      description: 'Cross-platform apps in Flutter',
      icon: '📱',
      features: ['iOS & Android', 'Cross-platform', 'Native Performance', 'Custom UI/UX'],
    ),
    Service(
      title: 'Firebase Integrations',
      description: 'Auth, Firestore, Notifications',
      icon: '🔥',
      features: ['Authentication', 'Real-time Database', 'Push Notifications', 'Cloud Functions'],
    ),
    Service(
      title: 'UI/UX Development',
      description: 'Interactive, responsive, modern designs',
      icon: '🎨',
      features: ['Modern Design', 'Responsive Layout', 'Animations', 'User Experience'],
    ),
    Service(
      title: 'API Integrations',
      description: 'RESTful services, third-party APIs',
      icon: '🔌',
      features: ['REST APIs', 'Third-party Services', 'Data Management', 'Error Handling'],
    ),
    Service(
      title: 'State Management Solutions',
      description: 'Provider, Riverpod, GetX',
      icon: '🔄',
      features: ['Provider Pattern', 'Reactive Programming', 'State Persistence', 'Performance'],
    ),
    Service(
      title: 'Code Architecture Consulting',
      description: 'MVVM, scalable patterns',
      icon: '🏗️',
      features: ['Clean Architecture', 'Scalable Patterns', 'Code Review', 'Best Practices'],
    ),
  ];

  static const List<Experience> experiences = [
    Experience(
      company: 'SalesGO CRM Technologies',
      position: 'Flutter Developer',
      startDate: '2022',
      endDate: null,
      isCurrent: true,
      technologies: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'MVVM'],
      responsibilities: [
        'Spearheaded SalesGo 3.0 with 2FA, geofencing, voice-to-text, push notifications',
        'Maintained SalesGo 2.1 CRM',
        'Built SalesGo Bandhan Visits 3.0 (Flutter)',
        'Developed SalesGo Leads with LinkedIn integration',
      ],
    ),
    Experience(
      company: 'Brototype',
      position: 'Flutter Developer',
      startDate: '2022',
      endDate: '2022',
      isCurrent: false,
      technologies: ['Flutter', 'Dart', 'Firebase', 'Provider', 'Git'],
      responsibilities: [
        'Built multiple reviewed projects (self-learning & mentoring)',
        'Collaborated with team members on complex features',
        'Implemented best practices and clean code principles',
      ],
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Groomly – Salon Booking App',
      description: 'Dark theme salon booking app with comprehensive features',
      longDescription: 'A modern salon booking application featuring dark theme design, advanced booking system, stylist selection, and integrated payment processing. The app was fully designed in Figma before development.',
      technologies: ['Flutter', 'Dart', 'Firebase', 'Payment Gateway', 'MVVM'],
      imageUrl: 'assets/images/projects/groomly.png',
      githubUrl: 'https://github.com/saijithc/groomly',
      liveUrl: null,
      features: [
        'Dark theme design',
        'Advanced booking system',
        'Stylist selection',
        'Payment integration',
        'User authentication',
        'Real-time updates',
      ],
    ),
    Project(
      title: 'Music Pill – Offline Music Player',
      description: 'Feature-rich offline music player with modern UI',
      longDescription: 'A comprehensive offline music player built with Flutter featuring MVVM architecture, local storage with Hive, and GetX state management. Includes playlists, favorites, and a mini-player.',
      technologies: ['Flutter', 'Dart', 'Hive', 'GetX', 'MVVM'],
      imageUrl: 'assets/images/projects/music_pill.png',
      githubUrl: 'https://github.com/saijithc/music-pill',
      liveUrl: null,
      features: [
        'Offline music playback',
        'Playlist management',
        'Favorites system',
        'Mini-player interface',
        'Local storage',
        'Modern UI design',
      ],
    ),
    Project(
      title: 'Tailus – Social Media App',
      description: 'Full-featured social media platform with real-time communication',
      longDescription: 'A comprehensive social media application featuring multiple authentication methods, real-time chat, voice/video calls, posts, stories, and push notifications.',
      technologies: ['Flutter', 'Dart', 'Firebase', 'WebRTC', 'Provider'],
      imageUrl: 'assets/images/projects/tailus.png',
      githubUrl: 'https://github.com/saijithc/tailus',
      liveUrl: null,
      features: [
        'Multiple authentication methods',
        'Real-time chat',
        'Voice/video calls',
        'Posts and stories',
        'Push notifications',
        'Social interactions',
      ],
    ),
  ];

  static const List<PricingPlan> pricingPlans = [
    PricingPlan(
      name: 'Starter Plan',
      description: 'Perfect for small projects and MVPs',
      price: 499,
      currency: '\$',
      ctaText: 'Get Started',
      features: [
        'Basic app development',
        'Simple UI/UX design',
        'Firebase integration',
        '1 month support',
        'Basic documentation',
      ],
    ),
    PricingPlan(
      name: 'Growth Plan',
      description: 'Ideal for growing businesses',
      price: 999,
      currency: '\$',
      isPopular: true,
      ctaText: 'Choose Growth',
      features: [
        'Advanced app features',
        'Custom UI/UX design',
        'Full Firebase suite',
        'API integrations',
        '3 months support',
        'Performance optimization',
      ],
    ),
    PricingPlan(
      name: 'Premium Plan',
      description: 'Complete custom app solutions',
      price: 1499,
      currency: '\$',
      ctaText: 'Go Premium',
      features: [
        'Full custom development',
        'Premium UI/UX design',
        'Advanced integrations',
        'State management setup',
        '6 months support',
        'Code architecture consulting',
        'Deployment assistance',
      ],
    ),
  ];

  static const List<Achievement> achievements = [
    Achievement(
      title: 'Projects Completed',
      description: 'Successfully delivered projects',
      value: 30,
      suffix: '+',
      icon: '🚀',
    ),
    Achievement(
      title: 'Years of Experience',
      description: 'Professional development experience',
      value: 3,
      suffix: '+',
      icon: '💼',
    ),
    Achievement(
      title: 'Traffic Growth',
      description: 'Organic traffic improvement',
      value: 100,
      suffix: '%',
      icon: '📈',
    ),
    Achievement(
      title: 'Client Satisfaction',
      description: 'Happy clients served',
      value: 50,
      suffix: '+',
      icon: '😊',
    ),
  ];
}
