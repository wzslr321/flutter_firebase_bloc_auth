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
import 'router/app_router.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  final userRepository = UserRepository();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await Firebase.initializeApp();

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
            create: (ctx) => AuthBloc(userRepository: userRepository)),
        BlocProvider<InternetCubit>(
            create: (ctx) => InternetCubit(connectivity: connectivity))
      ],
      child: MaterialApp(
        title: 'TwitterCopycat',
        theme: ThemeData(
          primarySwatch: primaryBlueColor,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
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
