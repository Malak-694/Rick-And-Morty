import 'package:flutter_application_6/data/api/character_api.dart';
import 'package:flutter_application_6/data/models/character.dart';

class CharacterRepo {
  final CharacterApi characterApi;

  CharacterRepo({required this.characterApi});
  Future<List<Character>> getAllCharacters() async {
    final characters = await characterApi.getAllCharacters();
    return characters;
  }
}
