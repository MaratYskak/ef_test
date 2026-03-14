import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/characters/data/datasources/characters_remote_datasource.dart';
import '../../features/characters/data/repositories/characters_repository_impl.dart';
import '../../features/characters/domain/repositories/characters_repository.dart';
import '../../features/characters/domain/usecases/get_characters.dart';
import '../../features/characters/presentation/bloc/characters_bloc.dart';
import '../../features/favorites/data/datasources/favorites_local_datasource.dart';
import '../../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../../features/favorites/domain/repositories/favorites_repository.dart';
import '../../features/favorites/domain/usecases/favorites_usecases.dart';
import '../../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Characters
  sl.registerFactory(() => CharactersBloc(getCharacters: sl()));
  sl.registerLazySingleton(() => GetCharacters(sl()));
  sl.registerLazySingleton<CharactersRepository>(
    () => CharactersRepositoryImpl(remoteDataSource: sl(), favoritesLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CharactersRemoteDataSource>(
    () => CharactersRemoteDataSourceImpl(dio: sl()),
  );

  // Features - Favorites
  sl.registerFactory(() => FavoritesBloc(getFavorites: sl(), addFavorite: sl(), removeFavorite: sl()));
  sl.registerLazySingleton(() => GetFavorites(sl()));
  sl.registerLazySingleton(() => AddFavorite(sl()));
  sl.registerLazySingleton(() => RemoveFavorite(sl()));
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(),
  );

  // Features - Settings
  sl.registerFactory(() => SettingsBloc(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton(() => Dio());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
