import 'dart:convert';
/// id : ""
/// title : "Harry Potter and the Cursed Child"
/// description : ""
/// rating : "3.4"
/// pages : 234
/// language : "ENG"
/// audiolen : "20"
/// author : "J.K. Rowling"
/// aboutAuthor : ""
/// bookurl : ""
/// audiourl : ""
/// category : ""
/// price : 23
/// numberofRating : 232

Bookmodel bookmodelFromJson(String str) => Bookmodel.fromJson(json.decode(str));
String bookmodelToJson(Bookmodel data) => json.encode(data.toJson());
class Bookmodel {
  Bookmodel({
      String? id, 
      String? title, 
      String? description, 
      String? rating, 
      num? pages, 
      String? language, 
      String? audiolen, 
      String? author, 
      String? aboutAuthor, 
      String? bookurl, 
      String? audiourl, 
      String? category, 
      num? price, 
      num? numberofRating,}){
    _id = id;
    _title = title;
    _description = description;
    _rating = rating;
    _pages = pages;
    _language = language;
    _audiolen = audiolen;
    _author = author;
    _aboutAuthor = aboutAuthor;
    _bookurl = bookurl;
    _audiourl = audiourl;
    _category = category;
    _price = price;
    _numberofRating = numberofRating;
}

  Bookmodel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _rating = json['rating'];
    _pages = json['pages'];
    _language = json['language'];
    _audiolen = json['audiolen'];
    _author = json['author'];
    _aboutAuthor = json['aboutAuthor'];
    _bookurl = json['bookurl'];
    _audiourl = json['audiourl'];
    _category = json['category'];
    _price = json['price'];
    _numberofRating = json['numberofRating'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _rating;
  num? _pages;
  String? _language;
  String? _audiolen;
  String? _author;
  String? _aboutAuthor;
  String? _bookurl;
  String? _audiourl;
  String? _category;
  num? _price;
  num? _numberofRating;
Bookmodel copyWith({  String? id,
  String? title,
  String? description,
  String? rating,
  num? pages,
  String? language,
  String? audiolen,
  String? author,
  String? aboutAuthor,
  String? bookurl,
  String? audiourl,
  String? category,
  num? price,
  num? numberofRating,
}) => Bookmodel(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  rating: rating ?? _rating,
  pages: pages ?? _pages,
  language: language ?? _language,
  audiolen: audiolen ?? _audiolen,
  author: author ?? _author,
  aboutAuthor: aboutAuthor ?? _aboutAuthor,
  bookurl: bookurl ?? _bookurl,
  audiourl: audiourl ?? _audiourl,
  category: category ?? _category,
  price: price ?? _price,
  numberofRating: numberofRating ?? _numberofRating,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get rating => _rating;
  num? get pages => _pages;
  String? get language => _language;
  String? get audiolen => _audiolen;
  String? get author => _author;
  String? get aboutAuthor => _aboutAuthor;
  String? get bookurl => _bookurl;
  String? get audiourl => _audiourl;
  String? get category => _category;
  num? get price => _price;
  num? get numberofRating => _numberofRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['rating'] = _rating;
    map['pages'] = _pages;
    map['language'] = _language;
    map['audiolen'] = _audiolen;
    map['author'] = _author;
    map['aboutAuthor'] = _aboutAuthor;
    map['bookurl'] = _bookurl;
    map['audiourl'] = _audiourl;
    map['category'] = _category;
    map['price'] = _price;
    map['numberofRating'] = _numberofRating;
    return map;
  }

}