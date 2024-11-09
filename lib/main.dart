import 'package:book_app/app_module.dart';
import 'package:book_app/app_widget.dart';
import 'package:book_app/database/hive_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/secrets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSettings.start();
  await Hive.openBox('book');
  await Supabase.initialize(
    url: urlSupabase,
    anonKey: apiKey,
  );

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
