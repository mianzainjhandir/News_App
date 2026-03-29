import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:news_app/model/category_news.dart';
import 'package:news_app/model/news_channel_headlines_model.dart';

class NewsRepository {

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async{

    String url = 'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=54088dfb12f1425d914f10db04e6f29f';
    ;

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){

      final body = jsonDecode(response.body.toString());

      return NewsChannelHeadlinesModel.fromJson(body);

    }
    throw Exception("Error");
  }

  Future<CategoryNewsModel> fetchCategoriesNewsApi(String category) async{

    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=54088dfb12f1425d914f10db04e6f29f';;

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){

      final body = jsonDecode(response.body.toString());

      return CategoryNewsModel.fromJson(body);

    }
    throw Exception("Error");
  }
}

