import 'package:dio/dio.dart';
import '../models/character_model.dart';

abstract class CharactersRemoteDataSource {
  Future<List<CharacterModel>> getCharacters(int page);
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final Dio dio;
  CharactersRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CharacterModel>> getCharacters(int page) async {
    final response = await dio.get('https://rickandmortyapi.com/api/character', queryParameters: {'page': page});
    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
