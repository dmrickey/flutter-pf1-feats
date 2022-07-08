import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../models/feat.dart';
import 'description_view.dart';

class FeatsList extends StatefulWidget {
  const FeatsList({Key? key}) : super(key: key);

  @override
  State<FeatsList> createState() => _FeatsListState();
}

class _FeatsListState extends State<FeatsList> {
  var _loaded = <Feat>[];
  var _filtered = <Feat>[];
  String _filter = "";

  final TextEditingController _textController = TextEditingController();

  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feat Descriptions'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter a search term',
                suffixIcon: IconButton(
                    onPressed: () {
                      _textController.clear();
                      setState(() {
                        _filter = "";
                      });
                    },
                    icon: const Icon(Icons.clear, color: Colors.red))),
            onChanged: (String value) {
              setState(() {
                _filter = value;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, i) {
                return Column(children: [
                  ListTile(
                    title: Center(
                      child: Text(
                        _filtered[i].name,
                        style: _biggerFont,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ItemDescription(item: _filtered[i]),
                        ),
                      );
                    },
                  ),
                  i != _filtered.length - 1 ? const Divider() : const Text(' '),
                ]);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  void initStateAsync() async {
    /* list all files in database dir */
    // final dir = Directory('./assets/database');
    // final List<FileSystemEntity> entities = await dir.list().toList();
    // entities.forEach(print);

    /* uncomment this and method below to re-import feats db */
    // await importFeats();

    /* make sure this file is defined in pubspec.yaml assets*/
    String dbPath = 'assets/database/feats.db';
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbPath);

    var store = intMapStoreFactory.store('feats');

    final recordSnapshot = await store.find(db);
    // should be mapping `snapshot.value` to a real object, but I'm lazy and haven't done that yet
    var loaded =
        recordSnapshot.map((snapshot) => Feat(snapshot.value)).toList();
    loaded.sort((a, b) => a.name.compareTo(b.name));
    setState(() {
      _loaded = loaded;
    });
  }

  @override
  void setState(VoidCallback fn) {
    fn();

    if (_filter.isEmpty) {
      _filtered = _loaded;
    } else {
      _filtered = _loaded
          .where((f) => f.name.toLowerCase().contains(_filter.toLowerCase()))
          .toList();
    }

    super.setState(() {});
  }

  // @override
  // void setState(fn) {
  //   super.setState(fn);
  // }

  /* import feats from previously exported file */
  // Future importFeats() async {
  /* make sure this file is defined in pubspec.yaml assets*/
  //   var featsJson =
  //       await rootBundle.loadString('assets/database/feats.export.json');
  //   var map = jsonDecode(featsJson) as Map;
  //   DatabaseFactory dbFactory = databaseFactoryIo;
  //   var importedFeatsDb =
  //       await importDatabase(map, dbFactory, 'assets/database/feats.db');
  // }
}