import 'package:flutter_pf1_feats/models/list_item.dart';

class Feat extends ListItem {
  Feat(dynamic feat)
      : super(feat['name'], feat['data']['description']['value']);
}
