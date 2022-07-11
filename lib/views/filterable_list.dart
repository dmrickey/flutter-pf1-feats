import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    var loaded = await loadFeats();
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

  Future<List<Feat>> loadFeats() async {
    var featsString = await rootBundle.loadString('assets/database/feats.json');
    return json.decode(featsString).map<Feat>((f) => Feat(f)).toList();
  }
}
