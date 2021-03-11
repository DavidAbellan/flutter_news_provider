import 'package:flutter/material.dart';
import 'package:newsprovider/src/models/category_model.dart';
import 'package:newsprovider/src/services/news_service.dart';
import 'package:newsprovider/src/theme/chikatilo_dark_theme.dart';
import 'package:newsprovider/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          _ListaCategorias(),
          Expanded(child: ListaNoticias(newsService.getArticlesbyCategory))
        ],
      ),
    ));
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<NewsService>(context).categorias;
    return Container(
      width: double.infinity,
      height: 80,
      color: Colors.red,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (BuildContext context, int index) {
          //Capitalizar la primera letra
          final cName = categorias[index].name;
          return Container(
            width: 110,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _CategoryButton(categorias[index]),
                  SizedBox(height: 5),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Categoria categoria;
  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    //para cambiar de color el icono
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        //Usando el provider en un on tap por ejemplo
        //el elemento no se tiene que redibujar
        //asi que ponemos el listen en false
        final newsService = Provider.of<NewsService>(context, listen: false);

        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          categoria.icon,
          color: (newsService.selectedCategory == this.categoria.name)
              ? miTema.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
