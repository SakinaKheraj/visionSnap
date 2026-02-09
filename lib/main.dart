import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/constants/app_constants.dart';

import 'features/auth/presentation/pages/signup_screen.dart';
import 'core/theme/glass_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // If required environment variables are missing, show a helpful error UI
  if (!ApiConstants.isConfigured) {
    runApp(const EnvErrorApp());
    return;
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const VisionSnapApp());
}

class EnvErrorApp extends StatelessWidget {
  const EnvErrorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VisionSnap (Missing env) ',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Configuration Error')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Required environment variables are missing.\n\n'
              'Create a local .env from .env.example and add the values.\n'
              'See ENV_INSTRUCTIONS.md for details.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
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
