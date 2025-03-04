import 'package:flutter/material.dart';
import 'package:newproject/db/db.dart';
import 'package:newproject/modal/news_Modal.dart';

class NewsProvider with ChangeNotifier {
  DBHelper db = DBHelper();
  List<NewsArticle>? _newsList;
  List<NewsArticle>? get newsList => _newsList;

  Future<void> fetchCartList() async {
    final list = await db.getCartList();
    _newsList = list;
    notifyListeners();
  }

  // Future<List<NewsArticle>> getCartList() async {
  //   return await db.getCartList();
  // }

  Future<void> deleteNewsArticle(int id) async {
    await db.deleteNewsArticle(id);
    await fetchCartList();
  }
}
