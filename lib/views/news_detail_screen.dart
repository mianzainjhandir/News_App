
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String newImage, newstitle, newsData, author, description, content, source;
   DetailScreen({super.key,
  required this.description,
    required this.author,
    required this.content,
    required this.newImage,
    required this.newsData,
    required this.newstitle,
    required this.source
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

