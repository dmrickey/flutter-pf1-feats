import 'package:db_pack_reader/views/filterable_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Feat Descriptions',
      home: FeatsList(),
    );
  }
}
