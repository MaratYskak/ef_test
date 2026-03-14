import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../characters/domain/entities/character.dart';
import '../../domain/usecases/favorites_usecases.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavorites getFavorites;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;

  FavoritesBloc({
    required this.getFavorites,
    required this.addFavorite,
    required this.removeFavorite,
  }) : super(FavoritesInitial()) {
    on<LoadFavoritesEvent>((event, emit) async {
      emit(FavoritesLoading());
      final result = await getFavorites();
      result.fold(
        (failure) => emit(FavoritesError(message: failure.message)),
        (favorites) => emit(FavoritesLoaded(favorites: favorites)),
      );
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      if (event.character.isFavorite) {
        await removeFavorite(event.character.id);
      } else {
        await addFavorite(event.character);
      }
      add(LoadFavoritesEvent());
    });
  }
}
