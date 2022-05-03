import '../Models/export.dart';

class AddWine extends StatefulWidget {
  const AddWine({Key? key}) : super(key: key);

  @override
  _AddWineState createState() => _AddWineState();
}

class _AddWineState extends State<AddWine> {

  TextEditingController controllerWine = TextEditingController();
  TextEditingController controllerSince = TextEditingController();
  TextEditingController controllerType = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  WinesModel? _winesModel;

  _registerWine(){
    _winesModel = WinesModel.createId();

    _winesModel?.wine = controllerWine.text;
    _winesModel?.since= int.parse(controllerSince.text);
    _winesModel?.type = controllerType.text;

    db
        .collection("wines")
        .doc(_winesModel?.id)
        .set(_winesModel!.toMap())
        .then((value) {

      controllerWine.clear();
      controllerSince.clear();
      controllerType.clear();

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return ShowDialog(
                title: 'Vinho Adicionado',
                list: [
                  Buttons(
                      onTap: (){
                        setState(() {
                          Navigator.pushReplacementNamed(context, "/listWine");
                        });
                      },
                      text: 'OK',
                      color: PaletteColor.icons),
                ],
              );
            });


    });
  }

  List<String> itensMenu = ["Home","Vinhos","Deletar vinhos"];

  _escolhaMenuItem(String itemEscolhido){

    switch (itemEscolhido){
      case "Home":
        Navigator.pushNamed(context, "/home");
        break;
      case "Vinhos":
        Navigator.pushNamed(context, "/listWine");
        break;
      case "Deletar vinhos":
        Navigator.pushNamed(context, "/deleteWine");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: PaletteColor.background,
      appBar: AppBar(
        backgroundColor: PaletteColor.icons,
        title: Text('CADASTRAR VINHO'),
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wine_bar,color: PaletteColor.icons,size: 100,
              ),
              Inputs(
                obscure: false,
                keyboardType: TextInputType.text,
                controller: this.controllerWine,
                hint: 'Nome',fonts: 20,
                width: width*0.8,
              ),
              Inputs(
                obscure: false,
                keyboardType: TextInputType.number,
                controller: this.controllerSince,
                hint: 'Ano',fonts: 20,
                width: width*0.8,
              ),
              Inputs(
                obscure: false,
                keyboardType: TextInputType.text,
                controller: this.controllerType,
                hint: 'Tipo',fonts: 20,
                width: width*0.8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Buttons(
                    onTap: ()=>_registerWine(),
                    text: 'CADASTRAR VINHO',
                    color: PaletteColor.icons
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
