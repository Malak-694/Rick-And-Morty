import 'package:flutter/material.dart';
import 'package:flutter_application_6/app_router.dart';

void main() {
  runApp( RickandMorty(appRouter: AppRouter(),));
}

class RickandMorty extends StatelessWidget {
  
final AppRouter appRouter;

  const RickandMorty({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRout,
    );
  }
}
