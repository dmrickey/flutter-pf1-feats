import 'package:flutter_pf1_feats/models/list_item.dart';

class Spell extends ListItem {
  Spell(dynamic spell)
      : super(spell['name'], spell['data']?['shortDescription'] ?? '');
}
