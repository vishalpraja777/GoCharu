class LinkFeed {
  final String linkName;
  final String link;

  LinkFeed({required this.linkName, required this.link});

  Map<String, dynamic> toJson() {
    return {"linkName": linkName, "link": link};
  }
}
