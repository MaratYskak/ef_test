import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failures.dart';
import '../../../characters/domain/entities/character.dart';
import '../../../characters/data/models/character_model.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Character>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavorites();
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(Character character) async {
    try {
      final model = CharacterModel(
        id: character.id,
        name: character.name,
        status: character.status,
        species: character.species,
        type: character.type,
        gender: character.gender,
        originName: character.originName,
        locationName: character.locationName,
        image: character.image,
        isFavorite: true,
      );
      await localDataSource.addFavorite(model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(int id) async {
    try {
      await localDataSource.removeFavorite(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
