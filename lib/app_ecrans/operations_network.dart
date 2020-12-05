import 'package:flutter/material.dart';
import 'package:exemple2/models/class_network.dart';
import 'package:exemple2/utilitaires/database_helper.dart';
import 'package:intl/intl.dart';
//DOC : https://pub.dev/packages/string_validator/install
import 'package:string_validator/string_validator.dart';

class OperationsNetwork extends StatefulWidget {
  final String _action;
  final Network _aNetwork;
  OperationsNetwork(this._aNetwork, this._action);
  @override
  State<StatefulWidget> createState() {
    return _OperationsNetworkState(this._aNetwork, _action);
  }
}

class _OperationsNetworkState extends State<OperationsNetwork> {
  String _action;
  final Network _aNetwork;
  _OperationsNetworkState(this._aNetwork, this._action);
  String _categorieSelectionnee = "";
  var _categories = [
    'Strength Training',
    'Running',
    'Pilates',
    'Yoga',
    'Other'
  ];

  DatabaseHelper helper = DatabaseHelper();

  TextEditingController surnameController = TextEditingController();
  TextEditingController fornameController = TextEditingController();
  TextEditingController telnumberController = TextEditingController();
  TextEditingController dateController =
      TextEditingController(); //Seulement pour enregistrer

  var _formEnregKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //Pour modifier et enlever
    _categorieSelectionnee = _aNetwork.categ;
    surnameController.text = _aNetwork.surname;
    fornameController.text = _aNetwork.forname;
    telnumberController.text = _aNetwork.telnumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline3;
    //Cas modifier et enlever
    bool _estVisibleButtonModifier = true;
    bool _estVisibleButtonEnlever = true;
    bool _estVisibleButtonEnregistrer = false;
    if (this._action == 'enregistrer') {
      _estVisibleButtonModifier = false;
      _estVisibleButtonEnlever = false;
      _estVisibleButtonEnregistrer = true;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Contact'),
        ),
        body: Form(
          key: _formEnregKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                FilmsImages(),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: TextFormField(
                    controller: surnameController,
                    onChanged: (value) {
                      _aNetwork.surname = surnameController.text;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'You must enter a surname';
                      }
                    },
                    style: textStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Surname',
                      hintText: 'Maximum 20 characters',
                      errorStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(5.0),
                      // ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: TextFormField(
                    controller: fornameController,
                    onChanged: (value) {
                      _aNetwork.forname = fornameController.text;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'You must enter a forname';
                      }
                    },
                    style: textStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Forname',
                      errorStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: telnumberController,
                            onChanged: (value) {
                              _aNetwork.telnumber =
                                  int.parse(telnumberController.text);
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Enter a telephone number';
                              } else {
                                if (!isNumeric(value)) {
                                  return 'Telephone number';
                                }
                              }
                            },
                            style: textStyle,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Number',
                              errorStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 25,
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            items: _categories.map((String aCateg) {
                              return DropdownMenuItem<String>(
                                value: aCateg,
                                child: Text(aCateg),
                              );
                            }).toList(),
                            value: _categorieSelectionnee,
                            onChanged: (String categ) {
                              _lorsqueOnChoisitUneCategorie(categ);
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Row(
                    children: <Widget>[
                      Visibility(
                        visible: _estVisibleButtonModifier,
                        child: Expanded(
                          child: RaisedButton(
                            color: const Color(0xFF200087),
                            textColor: const Color(0xFFE9E9E9),
                            child: Text(
                              'Modify',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () async {
                              String reponse = await this
                                  ._enregistrerChangements('modifier');
                              Navigator.pop(context, reponse);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _estVisibleButtonEnlever,
                        child: Expanded(
                          child: RaisedButton(
                            color: const Color(0xFF200087),
                            textColor: const Color(0xFFE9E9E9),
                            child: Text(
                              'Remove',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () async {
                              String reponse =
                                  await this._enregistrerChangements('enlever');
                              Navigator.pop(context, reponse);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _estVisibleButtonEnregistrer,
                        child: Expanded(
                          child: RaisedButton(
                            color: const Color(0xFF200087),
                            textColor: const Color(0xFFE9E9E9),
                            child: Text(
                              'Add to Contacts',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () async {
                              String reponse =
                                  await _enregistrerChangements('enregistrer');
                              Navigator.pop(context, reponse);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _vider() {
    surnameController.text = '';
    fornameController.text = '';
    telnumberController.text = '';
    _categorieSelectionnee = _categories[2];
  }

  void _lorsqueOnChoisitUneCategorie(String categ) {
    setState(() {
      this._categorieSelectionnee = categ;
    });
  }

  dynamic _enregistrerChangements(provenance) async {
    var resultat;
    String msg;
    _aNetwork.categ = _categorieSelectionnee;
    _aNetwork.surname = surnameController.text;
    _aNetwork.forname = fornameController.text;
    _aNetwork.telnumber = int.parse(telnumberController.text);
    if (provenance == 'modifier') {
      resultat = await helper.updateNetwork(_aNetwork);
      msg = 'modified';
    } else if (provenance == 'enlever') {
      resultat = await helper.removeNetwork(_aNetwork.id);
      msg = 'removed';
    } else {
      //enregistrer
      _aNetwork.id = null;
      _aNetwork.dateAdded =
          DateFormat.yMMMd().format(DateTime.now()); //Date du jour
      resultat =
          await helper.addNetwork(_aNetwork); //Retourne le dernier id inséré
      _aNetwork.id = resultat;
      msg = 'saved';
    }
    if (resultat != 0) {
      msg = "Contact " + _aNetwork.id.toString() + " was $msg";
    } else {
      msg = "Impossible to $msg the contact " + _aNetwork.id.toString();
    }
    return msg;
  }
}

class FilmsImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/group.jpg');
    Image image = Image(
      image: assetImage,
      width: 500.0,
      height: 200.0,
    );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: image,
    );
  }
}
