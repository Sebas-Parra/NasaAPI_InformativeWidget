import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/nasa_media_item.dart';
import '../providers/nasa_media_provider.dart';

class GalaxyGalleryPage extends StatefulWidget {
  const GalaxyGalleryPage({super.key});

  @override
  State<GalaxyGalleryPage> createState() => _GalaxyGalleryPageState();
}

class _GalaxyGalleryPageState extends State<GalaxyGalleryPage> {
  @override
  void initState() {
    super.initState();
    // Cargar categoría por defecto cuando entras
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<NasaMediaProvider>(context, listen: false);
      provider.loadCategory(provider.currentCategoryKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NASA Galaxies & Nebulae'),
        centerTitle: true,
      ),
      body: Consumer<NasaMediaProvider>(
        builder: (context, provider, _) {
          final categories = provider.categories;
          final isLoading = provider.isLoading;
          final error = provider.error;
          final List<NasaMediaItem> items = provider.items;

          return Column(
            children: [
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: categories.keys.map((key) {
                    final isSelected = key == provider.currentCategoryKey;
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(key),
                        selected: isSelected,
                        onSelected: (_) {
                          provider.loadCategory(key);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (error != null) {
                      return Center(
                        child: Text('Error: $error'),
                      );
                    }

                    if (items.isEmpty) {
                      return const Center(
                        child: Text('No se encontraron resultados'),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              if (item.imageUrl.isNotEmpty)
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image.network(
                                    item.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(16.0),
                                        child: Icon(
                                          Icons.broken_image_rounded,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Text(
                                  item.dateCreated,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Text(
                                  item.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: Text(item.title),
                                        content: SingleChildScrollView(
                                          child: Text(
                                            item.description,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Yap'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
