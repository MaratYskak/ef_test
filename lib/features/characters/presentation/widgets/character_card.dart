import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/character.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  const CharacterCard({required this.character, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: character.image,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => Container(color: Colors.grey[300]),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        character.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BlocBuilder<FavoritesBloc, FavoritesState>(
                      builder: (context, state) {
                        bool isFav = false;
                        if (state is FavoritesLoaded) {
                          isFav = state.favorites.any((f) => f.id == character.id);
                        }
                        return IconButton(
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                            child: Icon(
                              isFav ? Icons.star : Icons.star_border,
                              key: ValueKey<bool>(isFav),
                              color: isFav ? Colors.amber : null,
                            ),
                          ),
                          onPressed: () {
                            context.read<FavoritesBloc>().add(ToggleFavoriteEvent(character: character.copyWith(isFavorite: isFav)));
                          },
                        );
                      },
                    ),
                  ],
                ),
                Text('${character.status} - ${character.species}'),
                Text('Location: ${character.locationName}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
