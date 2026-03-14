import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failures.dart';
import '../entities/character.dart';
import '../repositories/characters_repository.dart';

class GetCharacters {
  final CharactersRepository repository;
  GetCharacters(this.repository);

  Future<Either<Failure, List<Character>>> call(int page) async {
    return await repository.getCharacters(page);
  }
}
