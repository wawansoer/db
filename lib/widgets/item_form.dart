import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/db_helper.dart';

class ItemForm extends StatefulWidget {
  final Item? item;

  ItemForm({this.item});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      _titleController.text = widget.item!.title;
      _descriptionController.text = widget.item!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            }),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(labelText: 'Description'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a description';
            }
            return null;
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                Item item = Item(
                    id: widget.item?.id,
                    title: _titleController.text,
                    description: _descriptionController.text);
                if (widget.item == null) {
                  await dbHelper.insterItem(item);
                } else {
                  await dbHelper.updateItem(item);
                }
                Navigator.pop(context);
              }
            },
            child: Text(widget.item == null ? 'Add' : 'Update'))
      ]),
    );
  }
}
