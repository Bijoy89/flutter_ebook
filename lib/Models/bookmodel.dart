class BookModel {
  String? id;
  String? title;
  String? description;
  String? rating;
  int? pages;
  String? language;
  String? audioLen;
  String? author;
  String? aboutAuthor;
  String? imagePublicId;  // NEW
  String? pdfPublicId;    // NEW

  String? bookurl;
  String? audioUrl;
  String? category;
  String? coverUrl;
  int? price;
  int? numberofRating;
  String? Search_Title_Index;
  String? Search_Author_Index;

  // These are for cloud storage (Cloudinary)
  String? imageUrl;
  String? pdfUrl;

  BookModel({
    this.id,
    this.title,
    this.description,
    this.rating,
    this.pages,
    this.language,
    this.audioLen,
    this.author,
    this.aboutAuthor,
    this.bookurl,
    this.audioUrl,
    this.category,
    this.imagePublicId,  // NEW
    this.pdfPublicId,    // NEW
    this.price,
    this.coverUrl,
    this.numberofRating,
    this.Search_Title_Index,
    this.Search_Author_Index,
    this.imageUrl,
    this.pdfUrl,
  });

  factory BookModel.fromMap(Map<String, dynamic> map, String docId) {
    return BookModel(
      id: docId,
      title: map['title'],
      author: map['author'],
      imageUrl: map['imageUrl'],
      bookurl: map['pdfUrl'],
      price: map['price'],
      rating: map['rating']?.toString(), // Force to string for consistency
      numberofRating: (map['numberofRating'] is int)
          ? map['numberofRating']
          : (map['numberofRating'] is double)
          ? (map['numberofRating'] as double).toInt()
          : 0, // fallback
      description: map['description'],
      aboutAuthor: map['aboutAuthor'],
      pages: map['pages'],
      language: map['language'],
      audioLen: map['audioLen'],
    );
  }



  BookModel.fromJson(Map<String, dynamic> json, [String? docId]) {
    id = docId ?? json['id'];
    title = json['title'];
    description = json['description'];
    rating = json['rating']?.toString();
    pages = int.tryParse(json['pages'].toString());
    language = json['language'];
    audioLen = json['audioLen'] ?? json['audioLength'];
    author = json['author'];
    aboutAuthor = json['aboutAuthor'];
    imagePublicId = json['imagePublicId'];  // NEW
    pdfPublicId = json['pdfPublicId'];    // NEW
    bookurl = json['bookurl'] ?? json['pdfUrl'];
    audioUrl = json['audioUrl'];
    category = json['category'];
    coverUrl = json['coverUrl'] ?? json['imageUrl'];
    price = int.tryParse(json['price'].toString());
    numberofRating = json['numberofRating'];
    Search_Title_Index = json['Search_Title_Index'];
    Search_Author_Index = json['Search_Author_Index'];
    imageUrl = json['imageUrl'];
    pdfUrl = json['pdfUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'rating': rating,
      'pages': pages,
      'language': language,
      'audioLen': audioLen,
      'author': author,
      'aboutAuthor': aboutAuthor,
      'bookurl': bookurl,
      'imagePublicId': imagePublicId,  // NEW
      'pdfPublicId': pdfPublicId,    // NEW
      'audioUrl': audioUrl,
      'category': category,
      'price': price,
      'coverUrl': coverUrl,
      'numberofRating': numberofRating,
      'Search_Title_Index': Search_Title_Index,
      'Search_Author_Index': Search_Author_Index,
      'imageUrl': imageUrl,
      'pdfUrl': pdfUrl,
    };
  }
}
