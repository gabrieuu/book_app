import 'package:book_app/modules/auth/controller/custom_auth_repository.dart';
import 'package:book_app/modules/auth/repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryMock extends Mock implements CustomAuthRepository {}

void main() {
  final service = AuthRepositoryMock();
}
