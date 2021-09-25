import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_dio_practice/constants/colors.dart';
import 'app_router.dart';
import 'business_logic/bloc_observer_helper/bloc_observer_helper.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
      theme: ThemeData(primaryColor: AppColors.myYellow),
    );
  }
}
