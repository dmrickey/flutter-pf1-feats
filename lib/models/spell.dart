import 'package:db_pack_reader/models/list_item.dart';

class Spell extends ListItem {
  Spell(dynamic spell)
      : super(spell['name'], spell['data']?['shortDescription'] ?? '');
}
