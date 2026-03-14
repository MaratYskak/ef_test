import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failures.dart';
import '../entities/character.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> getCharacters(int page);
}
