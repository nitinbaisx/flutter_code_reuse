class NewsArticle {
  int? id;
  final String title;
  final String description;
  final String urlToImage;

  NewsArticle({
    this.id,
    required this.title,
    required this.description,
    required this.urlToImage,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
    };
  }

  factory NewsArticle.fromMap(Map<String, dynamic> map) {
    return NewsArticle(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      urlToImage: map['urlToImage'],
    );
  }
}
