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
    instagram: 'www.instagram.com/_saijithsai?igsh=N3ppZXYyeG1xN3l1',
  );

  static const List<String> navigationItems = [
    'Home',
    'About Me',
    // 'Achievements',
    'Skills',
    'Services',
    'Experience',
  ];

  static List<Skill> skills = [
    // Frameworks & Languages
    Skill(
      name: 'Flutter',
      category: 'Framework',
      proficiency: 95,
      imagePath: 'assets/icons/flutter_logo.webp',
      learnMoreUrl: 'https://flutter.dev',
    ),
    Skill(
      name: 'Dart',
      category: 'Language',
      proficiency: 90,
      imagePath: 'assets/icons/dart.webp',
      learnMoreUrl: 'https://dart.dev',
    ),

    // State Management
    Skill(
      name: 'Provider',
      category: 'State Management',
      proficiency: 90,
      imagePath: 'assets/icons/provider.jpg',
      learnMoreUrl: 'https://pub.dev/packages/provider',
    ),
    Skill(
      name: 'Riverpod',
      category: 'State Management',
      proficiency: 85,
      imagePath: 'assets/icons/riverpod.png',
      learnMoreUrl: 'https://riverpod.dev',
    ),
    Skill(
      name: 'GetX',
      category: 'State Management',
      proficiency: 85,
      imagePath: 'assets/icons/getx.png',
      learnMoreUrl: 'https://pub.dev/packages/get',
    ),

    // Tools
    Skill(
      name: 'Firebase',
      category: 'Backend',
      proficiency: 90,
      imagePath: 'assets/icons/firebase.webp',
      learnMoreUrl: 'https://firebase.google.com',
    ),
    Skill(
      name: 'Hive',
      category: 'Database',
      proficiency: 90,
      imagePath: 'assets/icons/hive.png',
      learnMoreUrl: 'https://pub.dev/packages/hive',
    ),
    Skill(
      name: 'Figma',
      category: 'Design',
      proficiency: 75,
      imagePath: 'assets/icons/figma.webp',
      learnMoreUrl: 'https://figma.com',
    ),
    Skill(
      name: 'Git',
      category: 'Version Control',
      proficiency: 100,
      imagePath: 'assets/icons/git.webp',
      learnMoreUrl: 'https://git-scm.com',
    ),
    Skill(
      name: 'Postman',
      category: 'API Testing',
      proficiency: 80,
      imagePath: 'assets/icons/postman.webp',
      learnMoreUrl: 'https://postman.com',
    ),

    // Architecture
    Skill(
      name: 'MVVM',
      category: 'Architecture',
      proficiency: 90,
      imagePath: 'assets/icons/mvvm.png',
      learnMoreUrl:
          'https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel',
    ),
    Skill(
      name: 'MVC',
      category: 'Architecture',
      proficiency: 85,
      imagePath: 'assets/icons/mvc.jpg',
      learnMoreUrl:
          'https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller',
    ),
    Skill(
      name: 'RESTful APIs',
      category: 'Integration',
      proficiency: 100,
      imagePath: 'assets/icons/rest-api.webp',
      shouldAddColor: true,
      learnMoreUrl: 'https://restfulapi.net',
    ),
  ];

  static const List<Service> services = [
    Service(
      title: 'Mobile App Development',
      description: 'Cross-platform apps in Flutter',
      icon: '📱',
      features: [
        'iOS & Android',
        'Cross-platform',
        'Native Performance',
        'Custom UI/UX',
      ],
    ),
    Service(
      title: 'Firebase Integrations',
      description: 'Auth, Firestore, Notifications',
      icon: '🔥',
      features: [
        'Authentication',
        'Real-time Database',
        'Push Notifications',
        'Cloud Functions',
      ],
    ),
    Service(
      title: 'UI/UX Development',
      description: 'Interactive, responsive, modern designs',
      icon: '🎨',
      features: [
        'Modern Design',
        'Responsive Layout',
        'Animations',
        'User Experience',
      ],
    ),
    Service(
      title: 'API Integrations',
      description: 'RESTful services, third-party APIs',
      icon: '🔗',
      features: [
        'REST APIs',
        'Third-party Services',
        'Data Management',
        'Error Handling',
      ],
    ),
    Service(
      title: 'State Management Solutions',
      description: 'Provider, Riverpod, GetX',
      icon: '🔄',
      features: [
        'Provider Pattern',
        'Reactive Programming',
        'State Persistence',
        'Performance',
      ],
    ),
    Service(
      title: 'Code Architecture Consulting',
      description: 'MVVM, MVC, scalable patterns',
      icon: '🏗️',
      features: [
        'MVVM',
        'MVC',
        'Scalable Patterns',
        'Code Review',
        'Best Practices',
      ],
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
        'Spearheaded SalesGo 3.0 with 2FA, geofencing, voice-to-text, push notifications, Digicard integration',
        'Maintained SalesGo 2.1 CRM',
        'Built SalesGo Bandhan Visits 3.0 (Flutter)',
        'Developed SalesGo Leads with LinkedIn integration',
        'Developed MIS dashboard to track KPIs,generate reports, create campaigns etc',
        'Owned VAPT fixes and security hardening across apps',
        'Managed App Store and Play Store releases (internal, beta, production)',
        'Implemented Firebase Crashlytics and Analytics for proactive monitoring, user insights, and reducing production crashes',
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
      title: 'SalesGO Leads',
      description:
          'Complete frontend implementation for SalesGO Leads using Flutter & Dart',
      longDescription:
          'Built the entire frontend for SalesGO Leads, translating UI/UX into scalable Flutter components with high performance and responsiveness. Contributed directly to onboarding 2 new clients.',
      technologies: [
        'Flutter',
        'Dart',
        'MVVM',
        'Provider',
        'Firebase',
        'REST APIs',
        'CI/CD',
        'LinkedIn Integration',
        'Push Notifications',
      ],
      imageUrl: 'assets/images/salesgo_leads_ios.png',
      liveUrl: null,
      androidUrl:
          'https://play.google.com/store/apps/details?id=com.salesgo.salesgoleads30.salesgo_leads_30',
      iosUrl:
          'https://apps.apple.com/in/app/salesgo-leads/id6744051351', // replace with real App Store ID
      webUrl: 'https://leadsuat.salesgo.com', // replace with real web URL
      features: [
        'Implemented the complete frontend for the SalesGO Leads product using Flutter and Dart, translating UI/UX designs into scalable, high-performance interfaces and contributing to the successful onboarding of 2 new clients.',
        'Collaborated closely with UI/UX designers, product managers, and backend teams to convert wireframes, prototypes, and feature concepts into production-ready Flutter components following industry best practices.',
        'Worked with product managers to understand problem statements and business goals, and implemented frontend solutions that aligned with user needs, scalability, and maintainability.',
        'Ensured MVVM architecture and maintainable code by following Flutter best practices, including reusable widgets, modular structure, and optimized state management.',
        'Strengthened ownership across the frontend lifecycle, from feature implementation and refinement to client demos and production releases.',
      ],
    ),
    Project(
      title: 'SalesGO Visits',
      description: 'Feature development and enhancements for SalesGO Visits',
      longDescription:
          'Developed and enhanced major features in SalesGO Visits, improving usability, performance, and adoption. Helped enable onboarding of 4 new enterprise clients.',
      technologies: [
        'Flutter',
        'Dart',
        'MVVM',
        'Riverpod',
        'REST APIs',
        'Firebase',
        'CI/CD',
        'Geofencing',
        'Voice-to-text',
        'Push Notifications',
      ],
      imageUrl: 'assets/images/salesgo_visits_ios.png',
      liveUrl: null,
      androidUrl:
          'https://play.google.com/store/apps/details?id=in.nodetech.salesgo3',
      iosUrl:
          'https://apps.apple.com/in/app/salesgo-visits/id1622332742', // replace with real App Store ID
      webUrl: 'https://web30.salesgo.com/', // replace with real web URL
      features: [
        'Implemented geofencing-based check-in/out and visit scheduling for field teams',
        'Added voice-to-text notes and media attachments to streamline visit reporting',
        'Integrated push notifications for visit reminders',
        'Added DigiCard integration enabling logged-in users to share profile via QR code, WhatsApp, email, or LinkedIn',
        'Actively participated in feature discussions driven by client feedback, implementing refined user flows, responsive layouts, and interaction patterns that improved overall product experience.',
        'Worked with product managers to understand problem statements and business goals, and implemented frontend solutions that aligned with user needs, scalability, and maintainability.',
        'Ensured MVVM architecture and maintainable code by following Flutter best practices, including reusable widgets, modular structure, and optimized state management.',
        'Strengthened ownership across the frontend lifecycle, from feature implementation and refinement to client demos and production releases.',
        'Implemented Firebase Crashlytics and Analytics for proactive monitoring, user insights, and reducing production crashes',
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
      value: 20,
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
