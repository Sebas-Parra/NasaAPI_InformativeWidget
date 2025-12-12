import 'package:flutter/material.dart';
import 'galaxy_gallery_page.dart';

class HomeWidgetPage extends StatelessWidget {
  const HomeWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fondo degradado tipo widget de clima
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7C3AED), // morado
              Color(0xFFEC4899), // rosa
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          // ⬇️ AQUÍ EL CAMBIO: usamos ConstrainedBox en vez de SizedBox con height fija
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 340,
              minWidth: 340,
              minHeight: 160, // como mínimo, pero puede crecer un poco más
            ),
            child: Material(
              color: const Color(0xFF111827), // fondo oscuro
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GalaxyGalleryPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    // ⬇️ ESTE DETAIL IMPORTANTE: deja que la columna ocupe solo lo necesario
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.public,
                            color: Colors.white,
                            size: 28,
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                'NASA Space',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Galaxies & Nebulae',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Explore the cosmos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Tap to see Hubble & JWST images',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _MiniTelescopeInfo(
                            label: 'HST',
                            icon: Icons.camera_alt,
                          ),
                          _MiniTelescopeInfo(
                            label: 'JWST',
                            icon: Icons.camera,
                          ),
                          _MiniTelescopeInfo(
                            label: 'Spitzer',
                            icon: Icons.visibility,
                          ),
                          _MiniTelescopeInfo(
                            label: 'Chandra',
                            icon: Icons.blur_on_outlined,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniTelescopeInfo extends StatelessWidget {
  final String label;
  final IconData icon;

  const _MiniTelescopeInfo({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
