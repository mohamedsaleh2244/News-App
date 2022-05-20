import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;
import 'package:news_app/Models/article.dart';
import 'package:news_app/Providers/country_prov.dart';
import 'package:provider/provider.dart';

class ApiHelper{
  List<Article> list = [];
  getNews(BuildContext context)async {
    var response = await https.get(Uri.parse("https://newsapi.org/v2/top-headlines?country=${Provider.of<CountryProv>(context , listen: false).countryId}&apiKey=66616f15e55f4bcbb9ab645b9bf51599"));
    var body = jsonDecode(response.body);
    print(body["articles"][1]["urlToImage"]);
    try{
      if(body['status'] == 'ok'){
        body["articles"].forEach(
                (element){
              Article article = Article(
                  title: element["title"],
                  description: element["description"],
                  author: element["author"],
                  content: element["content"],
                  urlToImage: element["urlToImage"],
                  url: element["url"],
                  publishedAt: element["publishedAt"]
              );
              list.add(article);
            }
        );
      }
      else{
        print("Not Found from Api Helper");
      }
    }
    catch(e){
      print(e);
    }
    return list ;
  }
  getNewsByCategory(BuildContext context ,String categoryName )async {
    var response = await https.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=${Provider.of<CountryProv>(context , listen: false).countryId}&category=$categoryName&apiKey=66616f15e55f4bcbb9ab645b9bf51599"
    ));
    var body = jsonDecode(response.body);
    try{
      if(body['status'] == 'ok'){
        body["articles"].forEach(
          (element){
            Article article = Article(
                title: element["title"],
                description: element["description"],
                author: element["author"],
                content: element["content"],
                urlToImage: element["urlToImage"],
                url: element["url"],
                publishedAt: element["publishedAt"]
            );
              list.add(article);
            }
        );
      }
      else{
        print("Not Found from Api Helper");
      }
    }
    catch(e){
      print(e);
    }
    return list ;
  }
  getNewsBySearch(String search)async {
    var response = await https.get(Uri.parse("https://newsapi.org/v2/everything?q=$search&apiKey=66616f15e55f4bcbb9ab645b9bf51599"));
    var body = jsonDecode(response.body);
    try{
      if(body['status'] == 'ok'){
        body["articles"].forEach(
                (element){
              Article article = Article(
                  title: element["title"],
                  description: element["description"],
                  author: element["author"],
                  content: element["content"],
                  urlToImage: element["urlToImage"],
                  url: element["url"],
                  publishedAt: element["publishedAt"]
              );
              list.add(article);
            }
        );
      }
      else{
        print("Not Found from Api Helper");
      }
    }
    catch(e){
      print(e);
    }
    return list ;
  }
}
