import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/app_theme.dart';
import 'constants/app_constants.dart';
import 'view_models/portfolio_view_model.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'views/new_portfolio_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.hankenGrotesk();
  GoogleFonts.jetBrainsMono();
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PortfolioViewModel())],
      child: ThemeProvider(
        initTheme: AppTheme.darkTheme,
        builder: (context, myTheme) => MaterialApp(
          title: AppConstants.appName,
          theme: myTheme,
          debugShowCheckedModeBanner: false,
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
          home: const NewPortfolioHomePage(),
        ),
      ),
    );
  }
}
