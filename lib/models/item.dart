class Item {
  int? id;
  String title;
  String description;

  Item({this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
        id: map['id'], title: map['title'], description: map['description']);
  }
}
