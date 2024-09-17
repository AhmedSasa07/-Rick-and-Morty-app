import "package:bloc/bloc.dart";
import 'package:breaking/data/models/charactersModel.dart';
import 'package:breaking/data/repository/characters_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepo charactersRepo;
  List<CharacterModel> characters = [];

  CharactersCubit(this.charactersRepo) : super (CharactersInitial());
  List<CharacterModel> getAllCharacters() {
      charactersRepo.getAllCharacters().then((characters) => {
      emit(CharactersLoaded(characters)),
      this.characters = characters
    });
    return characters;
  }

}
