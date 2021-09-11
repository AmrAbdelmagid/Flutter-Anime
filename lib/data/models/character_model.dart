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
    characterAttributes = CharacterAttributes.fromJson(json['attributes']);
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
    imageSource = ImageSource.fromJson(json['image']);
  }
}

class ImageSource {
  String original = '';
  ImageSource.fromJson(Map<String, dynamic> json) {
    original = json['original'];
  }
}
// class DataModel {
//   List<BannerModel> banners = [];
//   List<ProductModel> products = [];
 
//   DataModel.fromJson(Map<String,dynamic> jsonData){
 
//     jsonData['banners'].forEach((element) {
//       banners.add(BannerModel.fromJson(element)); // this line
//     });
//     jsonData['products'].forEach((element) {
//       products.add(ProductModel.fromJson(element)); // and this line
//     });
//   }
// }

// class Character {
//   late String id;
//   late Map<String, dynamic> attributes;
//   late String name;
//   late String enName;
//   late String description;
//   late String image;
//   late String createdAt;

//   Character.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     attributes = json['attributes'];
//     name = attributes['name'];
//     enName = attributes['names']['en'];
//     description = attributes['description'];
//     image = attributes['image']['original'];
//     createdAt = attributes['createdAt'];
//   }
// }
