import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/feat.dart';
import '../models/spell.dart';
import 'filterable_list.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pf1 Items')),
      body: ListView(padding: const EdgeInsets.all(8), children: [
        ListTile(
          title: Center(
            child: Text(
              'Feats',
              style: _biggerFont,
            ),
          ),
          onTap: () async {
            var items = await loadFeats();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FilterableList(
                  items: items,
                  title: 'Feat Descriptions',
                ),
              ),
            );
          },
        ),
        ListTile(
          title: Center(
            child: Text(
              'Spells',
              style: _biggerFont,
            ),
          ),
          onTap: () async {
            var items = await loadSpells();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FilterableList(
                  items: items,
                  title: 'Spell Descriptions',
                ),
              ),
            );
          },
        ),
      ]),
    );
  }

  Future<List<Feat>> loadFeats() async {
    var featsJson = await rootBundle.loadString('assets/database/feats.json');
    List<Feat> feats =
        json.decode(featsJson).map<Feat>((f) => Feat(f)).toList();
    feats.sort((a, b) => a.name.compareTo(b.name));
    return feats;
  }

  Future<List<Spell>> loadSpells() async {
    var spellsJson = await rootBundle.loadString('assets/database/spells.json');
    List<Spell> spells =
        json.decode(spellsJson).map<Spell>((s) => Spell(s)).toList();
    spells.sort((a, b) => a.name.compareTo(b.name));
    return spells;
  }
}
