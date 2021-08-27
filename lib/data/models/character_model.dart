class Character {
  late String id;
  late Map<String, dynamic> attributes;
  late String name;
  late String description;
  late String image;

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'];
    name = attributes['name'];
    description = attributes['description'];
    image = attributes['image']['original'];
  }
}
