import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newproject/db/db.dart';
import 'package:http/http.dart' as http;
import 'package:newproject/modal/news_Modal.dart';
import 'package:newproject/utils/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String url =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=6a05c1c72c1a4aba93fb85fefa3ff702";
  List<NewsArticle> newsArticles = [];
  bool _isLoading = true;
  List<NewsArticle> _favoriteArticles = [];
  DBHelper _dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    try {
      final response = await http.get(Uri.parse(url));
      print('-------response-----${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> articlesJson = data["articles"];
        setState(() {
          newsArticles =
              articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: newsArticles.length,
                    itemBuilder: (context, index) {
                      final article = newsArticles[index];
                      return Card(
                        child: ListTile(
                          leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(article.urlToImage),
                            ),
                          ),
                          title: Text(
                              UtilsFun().truncateTitleWords(
                                article.title ?? 'No Title',
                              ),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          subtitle: Text(UtilsFun().truncateDescptionWords(
                              article.description ?? 'No Description')),
                          trailing: IconButton(
                              icon: const Icon(
                                Icons.favorite,
                              ),
                              onPressed: () => {
                                    _dbHelper
                                        .insertNewsArticle(
                                      NewsArticle(
                                        id: index,
                                        title: article.title,
                                        description: article.description,
                                        urlToImage: article.urlToImage,
                                      ),
                                    )
                                        .then((value) {
                                      print(
                                          '-----value------${value.toString()}');
                                      UtilsFun().getSuccessSnackbar(
                                          'Successfully Added', context);
                                    }).onError((error, stackTrace) {
                                      UtilsFun().getSuccessSnackbar(
                                          '$error', context);
                                    })
                                  }),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
