import 'package:flutter/material.dart';
import 'package:flutter_application_6/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_application_6/data/api/character_api.dart';
import 'package:flutter_application_6/data/repository/character_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_6/presentation/screens/characters_details.dart';
import 'package:flutter_application_6/presentation/screens/charctersScreen.dart';

class AppRouter {
  late CharacterRepo characterRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    characterRepository = CharacterRepo(characterApi: CharacterApi());
    charactersCubit = CharactersCubit(characterRepository);
  }
  Route? generateRout(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (BuildContext context) => charactersCubit,
                child: CharactersScreen(),
              ),
        );
      case '/characterDetailScreen':
        return MaterialPageRoute(
          builder: (_) => const CharactersDetailsScreen(),
        );
      default:
        return null;
    }
  }
}
