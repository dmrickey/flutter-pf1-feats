import 'package:flutter_pf1_feats/models/list_item.dart';

class Pf1Class extends ListItem {
  Pf1Class(dynamic pf1Class)
      : super(pf1Class['name'], pf1Class['data']['description']['value']);
}
