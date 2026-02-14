import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/glass_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/pages/signup_screen.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/home/presentation/pages/main_screen.dart';
import 'features/auth/presentation/pages/update_password_screen.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // If required environment variables are missing, show a helpful error UI
  if (!ApiConstants.isConfigured) {
    runApp(const EnvErrorApp());
    return;
  }

  // Initialize Supabase
  await Supabase.initialize(
    url: ApiConstants.supabaseUrl,
    anonKey: ApiConstants.supabaseAnonKey,
  );

  // Initialize Dependency Injection
  await di.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const VisionSnapApp());
}

class EnvErrorApp extends StatelessWidget {
  const EnvErrorApp({super.key});

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

class VisionSnapApp extends StatefulWidget {
  const VisionSnapApp({super.key});

  @override
  State<VisionSnapApp> createState() => _VisionSnapAppState();
}

class _VisionSnapAppState extends State<VisionSnapApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.passwordRecovery) {
        _navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const UpdatePasswordScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(const CheckAuthStatus()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'VisionSnap',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: GlassTheme.bgNavy,
          fontFamily: 'Inter',
          useMaterial3: true,
        ),
        // Define routes for navigation
        routes: {
          '/': (context) => const SignupScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const MainScreen(),
          '/update-password': (context) => const UpdatePasswordScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}
