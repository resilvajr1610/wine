import '../Models/export.dart';

class DeleteWine extends StatefulWidget {

  @override
  _DeleteWineState createState() => _DeleteWineState();
}

class _DeleteWineState extends State<DeleteWine> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  var _controllerWines = StreamController<QuerySnapshot>.broadcast();
  List _allResults = [];

  _data() async {
    var data = await db.collection("wines").get();

    setState(() {
      _allResults = data.docs;
    });
    return "complete";
  }

  _deleteWines(String idWine) {

    db.collection("wines")
        .doc(idWine)
        .delete()
        .then((_){
        _showDialog();

    });
  }

  _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return ShowDialog(
            title: 'Vinho Excluído',
            list: [
              Buttons(
                  onTap: (){
                    setState(() {
                      Navigator.pushReplacementNamed(context, "/deleteWine");
                    });
                  },
                  text: 'OK',
                  color: PaletteColor.icons),
            ],
          );
        });
  }

  List<String> itensMenu = ["Home","Vinhos","Adicionar vinhos"];

  _escolhaMenuItem(String itemEscolhido){

    switch (itemEscolhido){
      case "Home":
        Navigator.pushNamed(context, "/home");
        break;
      case "Vinhos":
        Navigator.pushNamed(context, "/listWine");
        break;
      case "Adicionar vinhos":
        Navigator.pushNamed(context, "/addWine");
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: PaletteColor.background,
        appBar: AppBar(
          backgroundColor: PaletteColor.icons,
          title: Text('DELETAR VINHO'),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<String>(
                icon: Icon(Icons.view_headline,color: Colors.white),
                onSelected: _escolhaMenuItem,
                itemBuilder: (context){
                  return itensMenu.map((String item) {
                    return PopupMenuItem<String>(
                        value: item,
                        child: Text(item));
                  }).toList();
                }
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: height * 0.5,
                  child: StreamBuilder(
                    stream: _controllerWines.stream,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (_allResults.length == 0) {
                            return Center(
                                child: Text(
                              'Sem dados!',
                              style: TextStyle(fontSize: 20),
                            ));
                          } else {
                            return ListView.separated(
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: _allResults.length,
                                itemBuilder: (BuildContext context, index) {
                                  DocumentSnapshot item = _allResults[index];

                                  WinesModel winesModel = WinesModel();

                                  winesModel.id = item["id"];
                                  winesModel.wine = item["wine"];
                                  winesModel.since = item["since"];
                                  winesModel.type = item["type"];

                                  return ItemsList(
                                    showIconDelete: true,
                                    wine: winesModel.wine,
                                    since: winesModel.since,
                                    type: winesModel.type,
                                    onPressed: () => _deleteWines(winesModel.id),
                                  );
                                });
                          }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
