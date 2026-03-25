import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:news_app/model/news_channel_headlines_model.dart';

class NewsRepository {

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi() async{

    String url = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=54088dfb12f1425d914f10db04e6f29f';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){

      final body = jsonDecode(response.body.toString());
      return NewsChannelHeadlinesModel.fromJson(body);

    }
    throw Exception("Error");


  }
}