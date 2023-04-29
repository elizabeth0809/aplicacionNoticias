import 'package:aplicacion_noticias/src/models/category_models.dart';
import 'package:aplicacion_noticias/src/theme/tema.dart';
import 'package:aplicacion_noticias/src/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/news_service.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          _ListaCategorias(),
          Expanded(
              child:
                  ListaNoticias(newsService.getArticulosCategoriaSeleccionada!))
        ],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButton(categories[index]),
                SizedBox(height: 5),
                //el toUppercase es para la primera letra en mayusculas despues se concatena quitando la primera letra en substring
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
        //print('${categoria.name}');
      },
      child: Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(categoria.icon,
              color: (newsService.selectedCategory == this.categoria.name)
                  ? miTema.accentColor
                  : Colors.black54)),
    );
  }
}
