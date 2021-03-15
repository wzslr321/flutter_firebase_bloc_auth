import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import './logic/auth/auth_cubit.dart';
import './logic/connection/internet_cubit.dart';
import 'constants/colors.dart';
import 'router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await Firebase.initializeApp();

  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({required this.appRouter, required this.connectivity});

  final AppRouter appRouter;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (ctx) => AuthCubit()),
        BlocProvider<InternetCubit>(create: (ctx) => InternetCubit())
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
      ..add(DiagnosticsProperty<Connectivity>('connectivity', connectivity));
  }
}
