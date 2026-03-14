import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failures.dart';
import '../../../characters/domain/entities/character.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<Character>>> getFavorites();
  Future<Either<Failure, void>> addFavorite(Character character);
  Future<Either<Failure, void>> removeFavorite(int id);
}
