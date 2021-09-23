import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'business_logic/bloc_observer_helper/bloc_observer_helper.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(AnimeApp(
    appRouter: AppRouter(),
  ));
}

class AnimeApp extends StatelessWidget {
  final AppRouter appRouter;

  const AnimeApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
