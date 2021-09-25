class CharactersData {
  List<Character> charactersData = [];

  CharactersData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      charactersData.add(Character.fromJson(element));
    });
  }
}

class Character {
  String id = '';
  CharacterAttributes? characterAttributes;
  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    characterAttributes = json['attributes'] != null
        ? CharacterAttributes.fromJson(json['attributes'])
        : null;
  }
}

class CharacterAttributes {
  String createdAt = '';
  String name = '';
  String description = '';
  ImageSource? imageSource;
  CharacterAttributes.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
    description = json['description'];
    imageSource =
        json['image'] != null ? ImageSource.fromJson(json['image']) : null;
  }
}

class ImageSource {
  String original = '';
  ImageSource.fromJson(Map<String, dynamic> json) {
    original = json['original'];
  }
}
