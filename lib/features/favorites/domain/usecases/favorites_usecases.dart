import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failures.dart';
import '../../../characters/domain/entities/character.dart';
import '../repositories/favorites_repository.dart';

class GetFavorites {
  final FavoritesRepository repository;
  GetFavorites(this.repository);
  Future<Either<Failure, List<Character>>> call() => repository.getFavorites();
}

class AddFavorite {
  final FavoritesRepository repository;
  AddFavorite(this.repository);
  Future<Either<Failure, void>> call(Character character) =>
      repository.addFavorite(character);
}

class RemoveFavorite {
  final FavoritesRepository repository;
  RemoveFavorite(this.repository);
  Future<Either<Failure, void>> call(int id) => repository.removeFavorite(id);
}
