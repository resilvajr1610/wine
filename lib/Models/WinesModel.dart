import '../Models/export.dart';

class WinesModel{

  String _id="";
  String _wine="";
  int _since=0;
  String _type="";

  WinesModel();

  WinesModel.createId(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference register = db.collection("wines");
    this.id = register.doc().id;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "id"    : this.id,
      "wine"  : this.wine,
      "since" :this.since,
      "type"  :this._type
    };
    return map;
  }


  String get wine => _wine;

  set wine(String value) {
    _wine = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  int get since => _since;

  set since(int value) {
    _since = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }
}