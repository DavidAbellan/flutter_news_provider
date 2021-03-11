import 'package:flutter/material.dart';
import 'package:newsprovider/src/pages/tab1_page.dart';
import 'package:newsprovider/src/pages/tab2_page.dart';
import 'package:newsprovider/src/services/news_service.dart';
import 'package:provider/provider.dart';

///mateapp

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //changenotifierprovider es donde empieza el provider(padre)
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //buscar dentro del context el navegacion model
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    // final newsService = Provider.of<NewsService>(context);

    return BottomNavigationBar(
      //current index para el boton del navigation quieres que aparezca seleccionado
      currentIndex: navegacionModel.paginaActual,
      //items es un array , tiene indice
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), title: Text('Para ti')),
        BottomNavigationBarItem(
            icon: Icon(Icons.public), title: Text('Highlights'))
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      //neverscrollable... para inhabilitar que se pueda deslizar con el dedo
      physics: NeverScrollableScrollPhysics(),
      children: [Tab1Page(), Tab2Page()],
    );
  }
}

//estructura modelo de provider básico
class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;

  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;
  set paginaActual(int valor) {
    this._paginaActual = valor;
    //después del set se nos hace necesario notificar
    //al resto de widgets que el índice ha cambiado
    // por eso el with ChangeNotifier y notifyListeners()
    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeIn);

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
