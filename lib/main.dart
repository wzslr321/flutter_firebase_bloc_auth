import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import './logic/auth_bloc/auth_bloc.dart';
import './logic/connection/internet_cubit.dart';
import 'constants/colors.dart';
import 'logic/observers/bloc_observer.dart';
import 'models/repositories/user_repository.dart';
import 'pages/authentication/login/login_screen.dart';
import 'pages/authentication/register/register_screen.dart';
import 'router/app_router.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final userRepository = UserRepository();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
    userRepository: userRepository,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({
    required this.appRouter,
    required this.connectivity,
    required this.userRepository,
  });

  final AppRouter appRouter;
  final Connectivity connectivity;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (ctx) =>
                AuthBloc(userRepository: userRepository)..add(AuthStarted())),
        BlocProvider<InternetCubit>(
            create: (ctx) => InternetCubit(connectivity: connectivity)),
      ],
      child: MaterialApp(
          title: 'TwitterCopycat',
          theme: ThemeData(
            primarySwatch: primaryBlueColor,
          ),
          onGenerateRoute: (settings) {
            if (settings.name == LoginScreen.routeName) {
              return MaterialPageRoute<LoginScreen>(builder: (context) {
                return LoginScreen(userRepository: userRepository);
              });
            } else if (settings.name == RegisterScreen.routeName) {
              return MaterialPageRoute<RegisterScreen>(builder: (context) {
                return RegisterScreen(userRepository: userRepository);
              });
            }
          }),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AppRouter>('appRouter', appRouter))
      ..add(DiagnosticsProperty<Connectivity>('connectivity', connectivity))
      ..add(DiagnosticsProperty<UserRepository>(
          'userRepository', userRepository));
  }
}
