import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import 'core/constants/api_constants.dart';
import 'core/theme/glass_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/signup_screen.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/home/presentation/pages/main_screen.dart';
import 'features/auth/presentation/pages/update_password_screen.dart';
import 'features/image_upload/presentation/bloc/upload_bloc.dart';
import 'injection_container.dart' as di;

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize cameras
  try {
    cameras = await availableCameras();
  } catch (e) {
    print('Error initializing cameras: $e');
    cameras = [];
  }

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
      title: 'VisionSnap (Missing env)',
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
        // Auth BLoC
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(const CheckAuthStatus()),
        ),
        // Upload BLoC - Add this
        BlocProvider(create: (_) => di.sl<UploadBloc>()),
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
        // Use home with AuthWrapper instead of initialRoute
        home: const AuthWrapper(),
        // Keep routes for named navigation
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const MainScreen(),
          '/update-password': (context) => const UpdatePasswordScreen(),
        },
      ),
    );
  }
}

/// Wrapper to check auth status and navigate accordingly
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Show loading while checking auth
        if (state is AuthLoading || state is AuthInitial) {
          return Scaffold(
            backgroundColor: GlassTheme.bgNavy,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Color(0xFF7C3AED)),
                  const SizedBox(height: 16),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // User is authenticated - go to home
        if (state is Authenticated) {
          return const MainScreen();
        }

        // User is not authenticated - show signup
        return const SignupScreen();
      },
    );
  }
}
