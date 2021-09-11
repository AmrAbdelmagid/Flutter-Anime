class Quote {
  late String content;
  // List<String> tags = [];

  Quote.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    // json['tags'].forEach((tag) {
    //   tags.add(tag.toString());
    // });
  }
}
