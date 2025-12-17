class Article {
  final String title;
  final String? description;
  final String? urlToImage;
  final String? content;
  final String? author;
  final String publishedAt;

  Article({
    required this.title,
    this.description,
    this.urlToImage,
    this.content,
    this.author,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'Không có tiêu đề',
      description: json['description'],
      urlToImage: json['urlToImage'],
      content: json['content'],
      author: json['author'],
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}