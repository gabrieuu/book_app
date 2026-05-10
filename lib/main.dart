import 'package:book_app/app_module.dart';
import 'package:book_app/app_widget.dart';
import 'package:book_app/database/hive_settings.dart';
import 'package:book_app/shared/env_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env.dev');

  await HiveSettings.start();
  await Hive.openBox('book');
  await Supabase.initialize(
    debug: true,
    url: dotenv.env[EnvVariables.SUPABASE_URL] ?? '',
    anonKey: dotenv.env[EnvVariables.SUPABASE_ANON_KEY] ?? '',
  );

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
