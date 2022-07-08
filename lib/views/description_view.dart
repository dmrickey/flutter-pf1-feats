import 'package:db_pack_reader/models/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ItemDescription extends StatelessWidget {
  const ItemDescription({super.key, required this.item});

  final ListItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.name,
        ),
      ),
      body: Center(
        child: Html(
          data: item.description,
        ),
      ),
    );
  }
}
