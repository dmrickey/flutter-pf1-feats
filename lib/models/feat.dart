import 'package:db_pack_reader/models/list_item.dart';

class Feat extends ListItem {
  Feat(dynamic feat)
      : super(feat['name'], feat['data']['description']['value']);
}
