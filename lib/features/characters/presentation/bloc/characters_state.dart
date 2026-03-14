part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class CharactersInitial extends CharactersState {}
class CharactersLoading extends CharactersState {}
class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  const CharactersLoaded({required this.characters});

  @override
  List<Object> get props => [characters];
}
class CharactersError extends CharactersState {
  final String message;
  const CharactersError({required this.message});

  @override
  List<Object> get props => [message];
}
