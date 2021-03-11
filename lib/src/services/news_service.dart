import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsprovider/src/models/category_model.dart';
import 'package:newsprovider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APiKEY = '355948c54bed4dcbbff753000a899db0';

class NewsService with ChangeNotifier {
  String _selectedCategory = 'business';
  List<Article> headlines = [];
  List<Categoria> categorias = [
    Categoria(FontAwesomeIcons.building, 'business'),
    Categoria(FontAwesomeIcons.tv, 'entertainment'),
    Categoria(FontAwesomeIcons.addressCard, 'general'),
    Categoria(FontAwesomeIcons.headSideVirus, 'health'),
    Categoria(FontAwesomeIcons.vials, 'science'),
    Categoria(FontAwesomeIcons.volleyballBall, 'sports'),
    Categoria(FontAwesomeIcons.memory, 'technology')
  ];

  //Vamos a crear un map para almacenar listas por categorias
  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    categorias.forEach((element) {
      //de esta forma se inicializa cada categoria en una lista
      this.categoryArticles[element.name] = new List();
    });
  }
  get selectedCategory => this._selectedCategory;
  set selectedCategory(String cat) {
    this._selectedCategory = cat;
    this._getArticlesByCategory(cat);
    notifyListeners();
  }

  _getArticlesByCategory(String cat) async {
    if (this.categoryArticles[cat].length > 0) {
      return this.categoryArticles[cat];
    }
    final url =
        '$_URL_NEWS/top-headlines?apiKey=$_APiKEY&country=us&category=$cat';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[cat].addAll(newsResponse.articles);
    notifyListeners();
  }

  getTopHeadlines() async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=355948c54bed4dcbbff753000a899db0';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  List<Article> get getArticlesbyCategory =>
      this.categoryArticles[this.selectedCategory];
}
