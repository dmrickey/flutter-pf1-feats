import 'package:flutter_pf1_feats/models/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ItemDescriptionPage extends StatelessWidget {
  const ItemDescriptionPage({super.key, required this.item});

  final ListItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.name,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Html(
            data: item.description,
          ),
        ),
      ),
    );
  }
}
