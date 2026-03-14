import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/failures.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/characters_repository.dart';
import '../datasources/characters_remote_datasource.dart';
import '../../../favorites/data/datasources/favorites_local_datasource.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDataSource remoteDataSource;
  final FavoritesLocalDataSource favoritesLocalDataSource;

  CharactersRepositoryImpl({
    required this.remoteDataSource,
    required this.favoritesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Character>>> getCharacters(int page) async {
    try {
      final remoteCharacters = await remoteDataSource.getCharacters(page);
      final List<Character> characters = [];
      for (var model in remoteCharacters) {
        final isFav = await favoritesLocalDataSource.isFavorite(model.id);
        characters.add(model.copyWith(isFavorite: isFav));
      }
      return Right(characters);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
