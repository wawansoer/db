import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/db_helper.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Item> items = [];

  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    List<Item> items = await dbHelper.getItems();

    setState(() {
      this.items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].description),
            // TODO add edit button
            // onTap:
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await dbHelper.deleteItem(items[index].id!);
                _loadItems();
              },
            ),
          );
        });
  }
}
