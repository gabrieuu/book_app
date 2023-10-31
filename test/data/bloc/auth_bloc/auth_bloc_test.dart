
import 'package:book_app/data/service/auth_service/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServiceMock extends Mock implements AuthService{}

void main() {
  final service = AuthServiceMock();
}