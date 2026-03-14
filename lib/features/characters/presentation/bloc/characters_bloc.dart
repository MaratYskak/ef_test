import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/character.dart';
import '../../domain/usecases/get_characters.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharacters getCharacters;
  int _currentPage = 1;
  bool _isFetching = false;

  CharactersBloc({required this.getCharacters}) : super(CharactersInitial()) {
    on<FetchCharactersEvent>((event, emit) async {
      if (_isFetching) return;
      _isFetching = true;

      if (state is CharactersInitial) {
        emit(CharactersLoading());
      }

      final result = await getCharacters(_currentPage);
      result.fold(
        (failure) => emit(CharactersError(message: failure.message)),
        (characters) {
          _currentPage++;
          final currentList = state is CharactersLoaded ? (state as CharactersLoaded).characters : <Character>[];
          emit(CharactersLoaded(characters: currentList + characters));
        },
      );
      _isFetching = false;
    });

    on<RefreshCharactersEvent>((event, emit) async {
      _currentPage = 1;
      emit(CharactersLoading());
      final result = await getCharacters(_currentPage);
      result.fold(
        (failure) => emit(CharactersError(message: failure.message)),
        (characters) {
          _currentPage++;
          emit(CharactersLoaded(characters: characters));
        },
      );
    });
  }
}
