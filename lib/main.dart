import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp(RickweMortyApp(appRouter: AppRouter(),));
}

class RickweMortyApp extends StatelessWidget {
  const RickweMortyApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}