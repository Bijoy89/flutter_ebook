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
  String? bookurl;
  String? audioUrl;
  String? category;
  String? coverUrl;
  int? price;
  int? numberofRating;
  String? Search_Title_Index;
  String? Search_Author_Index;

  BookModel(
      {this.id,
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
        this.price,
        this.coverUrl,
        this.numberofRating,
        this.Search_Title_Index,
        this.Search_Author_Index});



  BookModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["rating"] is String) {
      rating = json["rating"];
    }
    if (json["pages"] is int) {
      pages = json["pages"];
    }
    if (json["language"] is String) {
      language = json["language"];
    }
    if (json["audioLen"] is String) {
      audioLen = json["audioLen"];
    }
    if (json["author"] is String) {
      author = json["author"];
    }
    if (json["aboutAuthor"] is String) {
      aboutAuthor = json["aboutAuthor"];
    }
    if (json["bookurl"] is String) {
      bookurl = json["bookurl"];
    }
    if (json["audioUrl"] is String) {
      audioUrl = json["audioUrl"];
    }
    if (json["category"] is String) {
      category = json["category"];
    }
    if (json["coverUrl"] is String) {
      coverUrl = json["coverUrl"];
    }
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["numberofRating"] is int) {
      numberofRating = json["numberofRating"];
    }
    if (json["Search_Title_Index"] is String) {
      Search_Title_Index = json["Search_Title_Index"];
    }
    if (json["Search_Author_Index"] is String) {
      Search_Author_Index = json["Search_Author_Index"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["rating"] = rating;
    _data["pages"] = pages;
    _data["language"] = language;
    _data["audioLen"] = audioLen;
    _data["author"] = author;
    _data["aboutAuthor"] = aboutAuthor;
    _data["bookurl"] = bookurl;
    _data["audioUrl"] = audioUrl;
    _data["category"] = category;
    _data["coverUrl"] = coverUrl;
    _data["price"] = price;
    _data["numberofRating"] = numberofRating;
    _data["Search_Title_Index"] = Search_Title_Index;
    _data["Search_Author_Index"] = Search_Author_Index;
    return _data;
  }
}