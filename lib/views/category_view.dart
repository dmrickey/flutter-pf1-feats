import 'dart:convert';

import 'package:db_pack_reader/models/pf1_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/feat.dart';
import '../models/list_item.dart';
import '../models/spell.dart';
import 'filterable_list.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pf1 Items')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          buildListTile(context, 'Classes', loadClasses, 'Class Descriptions'),
          buildListTile(context, 'Feats', loadFeats, 'Feat Descriptions'),
          buildListTile(context, 'Spells', loadSpells, 'Spell Descriptions'),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, String label,
          Future<List<ListItem>> Function() getData, String categoryTitle) =>
      ListTile(
        title: Center(
          child: Text(
            label,
            style: _biggerFont,
          ),
        ),
        onTap: () async {
          var items = await getData();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilterableList(
                items: items,
                title: categoryTitle,
              ),
            ),
          );
        },
      );

  Future<List<Pf1Class>> loadClasses() async =>
      await loadJson('assets/database/classes.json', Pf1Class.new);

  Future<List<Feat>> loadFeats() async =>
      await loadJson('assets/database/feats.json', Feat.new);

  Future<List<Spell>> loadSpells() async =>
      await loadJson('assets/database/spells.json', Spell.new);

  Future<List<T>> loadJson<T extends ListItem>(
      String path, T Function(dynamic) ctor) async {
    var itemsJson = await rootBundle.loadString(path);
    List<T> items = json.decode(itemsJson).map<T>((s) => ctor(s)).toList();
    items.sort((a, b) => a.name.compareTo(b.name));
    return items;
  }
}
