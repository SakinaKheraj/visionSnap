import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  static String get visionApiKey => dotenv.env['GOOGLE_VISION_API_KEY'] ?? '';
  
  static const String visionApiUrl = 'https://vision.googleapis.com/v1/images:annotate';
  
  static bool get isConfigured {
    return supabaseUrl.isNotEmpty &&
          supabaseAnonKey.isNotEmpty &&
          visionApiKey.isNotEmpty;
  }
}