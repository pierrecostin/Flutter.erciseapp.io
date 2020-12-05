class Network {
  int _id;
  String _surname;
  String _forname;
  int _telnumber;
  String _categ;
  String _dateAdded;

  Network(this._id, this._surname, this._forname, this._telnumber, this._categ,
      this._dateAdded);

  int get id => _id;
  String get surname => _surname;
  String get forname => _forname;
  int get telnumber => _telnumber;
  String get categ => _categ;
  String get dateAdded => _dateAdded;

  //Mutateurs
  set id(int id) {
    //Seulement pour enregistrer à qui on doit donner numéro de départ=0
    this._id = id;
  }

  set surname(String surname) {
    if (surname.length <= 20) {
      this._surname = surname;
    }
  }

  set forname(String forname) {
    if (forname.length <= 20) {
      this._forname = forname;
    }
  }

  set telnumber(int telnumber) {
    this._telnumber = telnumber;
  }

  set categ(String categ) {
    this._categ = categ;
  }

  set dateAdded(String dateAdded) {
    this._dateAdded = dateAdded;
  }

  Map<String, dynamic> fromObjectToMap() {
    var map = Map<String, dynamic>();
    if (this._id != null) {
      map['id'] = this._id;
    }
    map['surname'] = this._surname;
    map['forname'] = this._forname;
    map['telnumber'] = this._telnumber;
    map['categ'] = this._categ;
    map['dateAdded'] = this._dateAdded;
    return map;
  }

  Network.fromMapToObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._surname = map['surname'];
    this._forname = map['forname'];
    this._telnumber = map['telnumber'];
    this._categ = map['categ'];
    this._dateAdded = map['dateAdded'];
  }
}
