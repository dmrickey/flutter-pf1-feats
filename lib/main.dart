import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Feat Descriptions',
      home: FeatsList(),
    );
  }
}

class FeatsList extends StatefulWidget {
  const FeatsList({Key? key}) : super(key: key);

  @override
  State<FeatsList> createState() => _FeatsListState();
}

class _FeatsListState extends State<FeatsList> {
  var _loaded = <dynamic>[];

  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [],
        title: const Text('Feat Descriptions'),
      ),
      body: ListView.builder(
        itemCount: _loaded.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return const Divider();
          }

          final index = i ~/ 2;

          return ListTile(
            title: Center(
              child: Text(
                _loaded[index]['name'],
                style: _biggerFont,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeatDescription(feat: _loaded[index]),
                ),
              );
            },
          );
        },
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
    var loaded = recordSnapshot.map((snapshot) => snapshot.value).toList();
    loaded.sort((a, b) => "${a['name']}".compareTo("${b['name']}"));
    setState(() {
      _loaded = loaded;
    });
  }

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

class FeatDescription extends StatelessWidget {
  const FeatDescription({super.key, required this.feat});

  // untyped map object pulled in from database
  final Map feat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          feat['name'],
        ),
      ),
      body: Center(
        child: Html(
          data: feat['data']['description']['value'],
        ),
      ),
    );
  }
}
