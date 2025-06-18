import 'package:flutter_ebook/Models/bookmodel.dart';

var categoryData = [
  {
    "icon": "",
    "label": "Science-fiction",
    "key": "science_fiction",
  },
  {
    "icon": "",
    "label": "Biography",
    "key": "biography",
  },
  {
    "icon": "",
    "label": "Horror",
    "key": "horror",
  },
  {
    "icon": "",
    "label": "Romance",
    "key": "romance",
  },
  {
    "icon": "",
    "label": "Travel",
    "key": "travel",
  },
  {
    "icon": "",
    "label": "Documentary",
    "key": "documentary",
  },
  {
    "icon": "",
    "label": "Mystery",
    "key": "mystery",
  },
  {
    "icon": "",
    "label": "Literature",
    "key": "literature",
  },
  {
    "icon": "",
    "label": "Personal growth",
    "key": "personal_growth",
  },
  {
    "icon": "",
    "label": "Novel",
    "key": "Novel",
  },
];
var bookData=[
 BookModel(
   id: "1",
   title:
   "War and peace",
   description:"War and Peace is a literary work by the Russian author Leo Tolstoy. Set during the Napoleonic Wars, the work comprises both a fictional narrative and chapters in which Tolstoy discusses history and philosophy.",
   aboutAuthor:"Count Lev Nikolayevich Tolstoy, usually referred to in English as Leo Tolstoy, was a Russian writer. He is regarded as one of the greatest and most influential authors of all time.",
   audioLen: "2 hr",
   author: "Leo Tolstoy",
   coverUrl: "Assets/Images/9781849908467-jacket-large.jpg",
   rating: "5.0",
   numberofRating: 10,
   category: "Mystery",
   price: 100,
 ),
  BookModel(
    id: "2",
    title:
    "Adventures of Pinocchio",
    description:"The Adventures of Pinocchio, commonly shortened to Pinocchio, is an 1883 children's fantasy novel by Italian author Carlo Collodi. It is about the mischievous adventures of an animated marionette named Pinocchio.",
    aboutAuthor:"Carlo Lorenzini, better known by the pen name Carlo Collodi, was an Italian author, humourist, and journalist, widely known for his fairy tale novel The Adventures of Pinocchio.",
    audioLen: "2 hr",
    author: "Carlo Collodi",
    coverUrl: "Assets/Images/137990385.jpg",
    rating: "4.7",
    numberofRating: 10,
    category: "Novel",
    price: 80,
  ),
  BookModel(
    id: "3",
    title:
    "A Tale of Two Cities",
    description:"A Tale of Two Cities is a historical novel published in 1859 by English author Charles Dickens, set in London and Paris before and during the French Revolution.",
    aboutAuthor:"Charles Dickens was an English writer and social critic. He is regarded as the greatest novelist of the Victorian era and created some of the world's best-known fictional characters.",
    audioLen: "2 hr",
    author: "Charles Dickens",
    coverUrl: "Assets/Images/a-tale-of-two-cities-431.jpg",
    rating: "5.0",
    numberofRating: 10,
    category: "Novel",
    price: 95,
  ),
  BookModel(
    id: "4",
    title:
    "The hunchback of Notre-Dame",
    description:"The Hunchback of Notre-Dame is a French Gothic novel by Victor Hugo, published in 1831. The title refers to the Notre-Dame Cathedral, which features prominently throughout the novel.",
    aboutAuthor:"Victor-Marie Hugo, vicomte Hugo was a French Romantic author, poet, essayist, playwright, journalist, human rights activist and politician. His most famous works are the novels The Hunchback of Notre-Dame and Les Misérables.",
    audioLen: "2 hr",
    author: "Victor Hugo",
    coverUrl: "Assets/Images/the-hunchback-of-notre-dame-9781645171836_hr.jpg",
    rating: "5.0",
    numberofRating: 10,
    category: "Romance",
    price: 76,
  ),

];