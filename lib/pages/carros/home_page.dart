import 'package:flutter/material.dart';
import 'package:flutter_carros/drawer_list.dart';
import 'package:flutter_carros/pages/carros/carro_form_page.dart';
import 'package:flutter_carros/pages/carros/carros_api.dart';
import 'package:flutter_carros/pages/carros/carros_page.dart';
import 'package:flutter_carros/pages/favoritos/favoritos_page.dart';
import 'package:flutter_carros/utils/alert.dart';
import 'package:flutter_carros/utils/nav.dart';
import 'package:flutter_carros/utils/pref.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    _tabController = TabController(length: 4, vsync: this);

    int tabIdx = await Prefs.getInt("tabIdx");

    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Carros",
        ),
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    text: "Clássicos",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Esportivos",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Luxo",
                    icon: Icon(Icons.directions_car),
                  ),
                  Tab(
                    text: "Favoritos",
                    icon: Icon(Icons.favorite),
                  )
                ],
              ),
      ),
      body: _tabController == null
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: <Widget>[
                CarrosPage(TipoCarro.classicos),
                CarrosPage(TipoCarro.esportivos),
                CarrosPage(TipoCarro.luxo),
                FavoritosPage(),
              ],
            ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: _onClickAdicionarCarro,
      ),
    );
  }

  _onClickAdicionarCarro(){
    push(context, CarroFormPage());
  }
}
