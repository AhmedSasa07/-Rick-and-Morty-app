import 'package:breaking/data/api/characters_web_service.dart';
import 'package:breaking/data/models/charactersModel.dart';
//Mine
// class CharactersRepo {
//   CharactersService charactersService;
//
//   CharactersRepo({required this.charactersService});
//
//   Future<List<CharacterModel>> getAllCharacters() async {
//     final characters = await charactersService.getAllCharacters();
//     return characters
//         .map((character) => CharacterModel.fromJson(character))
//         .toList();
//   }
// }
class CharactersRepo {
  CharactersService charactersService;

  CharactersRepo({required this.charactersService});

  Future<List<CharacterModel>> getAllCharacters() async {
    return await charactersService.getAllCharacters();
  }
}

