import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
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
