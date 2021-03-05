import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

import '../models/authentication_service.dart';

final authenticationServiceProvider = Provider<AuthenticationService>(
    (_) => AuthenticationService(FirebaseAuth.instance));
