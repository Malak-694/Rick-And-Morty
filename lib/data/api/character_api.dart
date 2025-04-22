import 'package:dio/dio.dart';
import 'package:flutter_application_6/constants/string.dart';
import 'package:flutter_application_6/data/models/character.dart';

class CharacterApi {
  late Dio dio;
  CharacterApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(milliseconds: 60 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
    dio = Dio(options);
  }
  Future<List<Character>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      print(response.data.toString());

      List<dynamic> charactersJson = response.data['results'];
      List<Character> characters =
          charactersJson
              .map((characterJson) => Character.fromJson(characterJson))
              .toList();

      return characters;
    } catch (e) {
      print('Failed to load characters: $e');
      return [];
    }
  }
}
