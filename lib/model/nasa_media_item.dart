class NasaMediaItem {
  final String nasaId;
  final String title;
  final String description;
  final String dateCreated;
  final String mediaType;
  final String imageUrl;

  NasaMediaItem({
    required this.nasaId,
    required this.title,
    required this.description,
    required this.dateCreated,
    required this.mediaType,
    required this.imageUrl,
  });

  factory NasaMediaItem.fromJson(Map<String, dynamic> item) {
    final dataList = item['data'] as List<dynamic>? ?? [];
    final linksList = item['links'] as List<dynamic>? ?? [];

    final data = dataList.isNotEmpty
        ? dataList.first as Map<String, dynamic>
        : <String, dynamic>{};

    final link = linksList.isNotEmpty
        ? linksList.first as Map<String, dynamic>
        : <String, dynamic>{};

    return NasaMediaItem(
      nasaId: data['nasa_id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      dateCreated: data['date_created'] ?? '',
      mediaType: data['media_type'] ?? '',
      imageUrl: link['href'] ?? '',
    );
  }
}
