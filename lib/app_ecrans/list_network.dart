import 'dart:async';
import 'package:flutter/material.dart';
import 'package:exemple2/models/class_network.dart';
import 'package:exemple2/app_ecrans/operations_network.dart';
import 'package:exemple2/utilitaires/database_helper.dart';
import 'package:sqflite/sqflite.dart';

Future<String> navigerEcrans(context, ecran) async {
  String reponse = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => ecran));
  return reponse;
}

class NetworkList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NetworkListState();
  }
}

class NetworkListState extends State<NetworkList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Network> networkList;
  int nbNetwork = 0;

  var _networkListStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    networkList = List<Network>();
    reactualiserListView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        key: _networkListStateKey,
        appBar: AppBar(
          title: Text('My Network List'),
          backgroundColor: const Color(0xFF200087),
        ),
        body: Column(
          children: [
            NetworkListView(networkList, this),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Network aNetwork = Network(null, null, null, 0, null, null);
            String action = await navigerEcrans(
              context,
              OperationsNetwork(aNetwork, 'enregistrer'),
            );
            reactualiserListView();
            montrerSnackBar(action);
          },
          tooltip: 'Modify a Contact',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void reactualiserListView() async {
    await databaseHelper.initializeDatabase();

    List<Network> networkList = await databaseHelper.getNetworkList();
    print('networkList: ${networkList.length}');
    setState(() {
      this.networkList = networkList;
      this.nbNetwork = networkList.length;
    });
  }

  void montrerSnackBar(item) {
    var snackBar = SnackBar(
      content: Text(item),
      action: SnackBarAction(label: "Close", onPressed: () {}),
    );

    //Scaffold.of(context).showSnackBar(snackBar);
    _networkListStateKey.currentState.showSnackBar(snackBar);
  }
}

class NetworkListView extends StatelessWidget {
  final List<Network> networkList;
  //Pouvoir accéder à reactualiserListView() de ListeFilmsState
  //que contient le setState. On reçoit donc la référence sur la classe ListeFilmsState

  dynamic _occurrenceNetworkListState;
  NetworkListView(this.networkList, this._occurrenceNetworkListState);
  String _action;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        //separated
        padding: const EdgeInsets.all(2),
        itemCount: networkList.length,
        itemBuilder: listBuilder,
      ),
    );
  }

  Widget listBuilder(BuildContext context, int index) {
    return Card(
      //bonne façon de mettre une couleur dans ListTile
      color: Colors.blueGrey[50],
      child: ListTile(
        leading: CircleAvatar(
          //backgroundImage: NetworkImage(imageUrl),
          backgroundImage: AssetImage('images/pierre.jpg'),
        ),
        //leading: AssetImage('assets/images/titanic.jpg'),
        title: Text(
          networkList[index].surname,
        ),
        subtitle: Text(
          networkList[index].telnumber.toString(),
        ),

        trailing: GestureDetector(
          child: Icon(
            Icons.more_vert,
            color: const Color(0xFF200087),
            size: 30,
          ),
          onTap: () async {
            _action = await navigerEcrans(
              context,
              OperationsNetwork(this.networkList[index], 'Modify a Contact'),
            );
            await _occurrenceNetworkListState.reactualiserListView();
            await _occurrenceNetworkListState.montrerSnackBar(_action);
          },
        ),
        onTap: () {},
      ),
    );
  }
}
