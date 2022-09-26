// To parse this JSON data, do
//
//     final blogPost = blogPostFromMap(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

BlogPost blogPostFromMap(String str) => BlogPost.fromMap(json.decode(str));

String blogPostToMap(BlogPost data) => json.encode(data.toMap());

class BlogPost {
  BlogPost({
    required this.author,
    required this.title,
    required this.category,
    required this.content,
    required this.imageLink,
  });

  String author="";
  String title="";
  String category="";
  String content="";
  String imageLink="";

   BlogPost.fromMap(Map<String, dynamic> json) {
     author = json['author'];
     title = json['title'];
     category = json['category'];
     content = json['content'];
     imageLink = json['imageLink'];
   }

  Map<String, dynamic> toMap() => {
    "author": author,
    "title": title,
    "category": category,
    "content": content,
    "imageLink": imageLink,
  };
  BlogPost.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data as Map<String, dynamic>);
}
