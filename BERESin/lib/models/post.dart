class Post {
  final String postId;
  final DateTime datePublished; // Consider using DateTime for datePublished
  final String postUrl;
  final String secondPostUrl; // Add this field

  const Post({
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.secondPostUrl, // Include in constructor
  });

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "datePublished": datePublished.toIso8601String(), // Convert to string if needed
    "postUrl": postUrl,
    "secondPostUrl": secondPostUrl, // Include in toJson
  };
}