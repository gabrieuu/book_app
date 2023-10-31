import 'package:book_app/app_widget.dart';
import 'package:book_app/data/controller/user_controller.dart';
import 'package:book_app/data/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://kkqlokylucifwisefqlw.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtrcWxva3lsdWNpZndpc2VmcWx3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5ODI0Njg5NiwiZXhwIjoyMDEzODIyODk2fQ.aTfCaefAOenOpNSmwH5S-y2W5tgq0FV_KasvTL0ZLZM",
  );

  runApp(const MyApp());

  Get.lazyPut<AuthService>(() => AuthService());
  Get.lazyPut<UserController>(() => UserController());

}