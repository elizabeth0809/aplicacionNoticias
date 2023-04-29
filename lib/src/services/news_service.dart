import 'package:aplicacion_noticias/src/models/category_models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';

final _APIKEY = '56af6b49e6b94fdf823cd529f8ec6bad';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.building, 'science'),
    Category(FontAwesomeIcons.headSideVirus, 'sports'),
    Category(FontAwesomeIcons.addressCard, 'technology'),
  ];
  Map<String, List<Article>> categoryArticles = {};
  NewsService() {
    this.getTopHeadlines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = new List.empty();
    });
    this.getArticlesByCategory(this._selectedCategory);
  }
  String get selectedCategory => this._selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory];
  getTopHeadlines() async {
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ve');
    final resp = await http.get(url);
    final newsResponse = NewsResponse.fromJson(resp.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }
    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ve&category=$category');
    final resp = await http.get(url);
    final newsResponse = NewsResponse.fromJson(resp.body);
    this.categoryArticles[category] = newsResponse.articles;

    notifyListeners();
  }
}
