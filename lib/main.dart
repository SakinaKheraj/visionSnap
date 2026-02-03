import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/main_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'core/theme/glass_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const VisionSnapApp());
}

class VisionSnapApp extends StatelessWidget {
  const VisionSnapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VisionSnap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: GlassTheme.bgNavy,
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const SignupScreen(),
    );
  }
}
