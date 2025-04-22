import 'package:bloc/bloc.dart';
import 'package:flutter_application_6/data/models/character.dart';
import 'package:flutter_application_6/data/repository/character_repo.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepo characterRepo;
  late List<Character> characters;

  CharactersCubit(this.characterRepo) : super(CharactersInitial());

  void getAllCharacters() async {
    try {
      emit(CharactersLoading());
      final characters = await characterRepo.getAllCharacters();
      this.characters = characters;
      emit(CharactersLoaded(characters));
    } catch (e) {
      emit(CharactersError(e.toString()));
      print("Cubit error: ${e.toString()}");
    }
  }
}
