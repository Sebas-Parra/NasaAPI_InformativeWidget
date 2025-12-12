import 'package:flutter/foundation.dart';
import '../controller/nasa_media_controller.dart';
import '../model/nasa_media_item.dart';

class NasaMediaProvider extends ChangeNotifier {
  final NasaMediaController _controller = NasaMediaController();

  List<NasaMediaItem> _items = [];
  bool _isLoading = false;
  String? _error;
  String _currentCategoryKey = 'Galaxies';

  List<NasaMediaItem> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get currentCategoryKey => _currentCategoryKey;

  final Map<String, String> categories = const {
    'Galaxies': 'galaxy',
    'Nebulae': 'nebula',
    'Hubble': 'hubble galaxy',
    'JWST': 'james webb galaxy',
  };

  Future<void> loadCategory(String categoryKey) async {
    _currentCategoryKey = categoryKey;
    _isLoading = true;
    _error = null;
    notifyListeners();

    final query = categories[categoryKey] ?? 'galaxy';

    try {
      final result = await _controller.searchAstronomyImages(query: query);
      _items = result;
    } catch (e) {
      _error = e.toString();
      _items = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
