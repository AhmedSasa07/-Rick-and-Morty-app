import 'package:breaking/business_logic/cubit/characters_cubit.dart';
import 'package:breaking/data/api/characters_web_service.dart';
import 'package:breaking/data/models/charactersModel.dart';
import 'package:breaking/data/repository/characters_repository.dart';
import 'package:breaking/presentation/screens/character_details_screen.dart';
import 'package:breaking/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';

class AppRouter {
  late CharactersRepo charactersRepo ;
  late CharactersCubit charactersCubit;
AppRouter (){
  charactersRepo = CharactersRepo(charactersService: CharactersService());
  charactersCubit = CharactersCubit(charactersRepo);
}

  Route ?generateRoute (RouteSettings settings){
    switch (settings.name) {
      case charactersScreen :return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create : (BuildContext context) => charactersCubit,
            child : CharactersScreen(),
          ),
      );
      case characterDetailsScreen :
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(builder: (_) =>  CharacterDetailsScreen(character: character,));

    }
    return null;
  }
}