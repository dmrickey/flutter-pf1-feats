import 'package:flutter/material.dart';
import '../models/list_item.dart';
import 'description_view.dart';

class FilterableList extends StatefulWidget {
  final List<ListItem> items;
  final String title;

  const FilterableList({Key? key, required this.items, required this.title})
      : super(key: key);

  @override
  State<FilterableList> createState() => _FilterableListState();
}

class _FilterableListState extends State<FilterableList> {
  var _filtered = <ListItem>[];
  String _filter = "";

  final TextEditingController _textController = TextEditingController();

  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter a search term',
              suffixIcon: Visibility(
                visible: _filter.isNotEmpty,
                child: IconButton(
                    onPressed: () {
                      _textController.clear();
                      setState(() {
                        _filter = "";
                      });
                    },
                    icon: const Icon(Icons.clear, color: Colors.red)),
              ),
            ),
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
    // init state based on passed in items
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    fn();

    if (_filter.isEmpty) {
      _filtered = widget.items;
    } else {
      _filtered = widget.items
          .where((f) => f.name.toLowerCase().contains(_filter.toLowerCase()))
          .toList();
    }

    super.setState(() {});
  }
}
