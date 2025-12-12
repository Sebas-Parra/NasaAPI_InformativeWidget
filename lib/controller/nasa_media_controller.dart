import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/nasa_media_item.dart';

class NasaMediaController {
  static const String _baseUrl = 'https://images-api.nasa.gov';

  Future<List<NasaMediaItem>> searchAstronomyImages({
    required String query,
    int page = 1,
  }) async {
    final params = <String, String>{
      'q': query,
      'media_type': 'image',
      'page': page.toString(),
    };

    final uri = Uri.parse('$_baseUrl/search').replace(
      queryParameters: params,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final collection = json['collection'] as Map<String, dynamic>? ?? {};
      final items = collection['items'] as List<dynamic>? ?? [];

      final list = items
          .map((e) => NasaMediaItem.fromJson(e as Map<String, dynamic>))
          .where(
            (item) => item.mediaType == 'image' && item.imageUrl.isNotEmpty,
          )
          .toList();

      return list;
    } else {
      throw Exception(
        'Error al buscar imágenes: ${response.statusCode}',
      );
    }
  }
}
