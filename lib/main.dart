import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/home_widget_page.dart';
import 'providers/nasa_media_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NasaMediaProvider(),
      child: MaterialApp(
        title: 'NASA Galaxies App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeWidgetPage(),
      ),
    );
  }
}
