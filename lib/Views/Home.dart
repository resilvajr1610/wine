import '../../Models/export.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  List<String> itensMenu = ["Vinhos","Deletar vinhos","Adicionar vinhos"];

  _escolhaMenuItem(String itemEscolhido){

    switch (itemEscolhido){
      case "Vinhos":
        Navigator.pushNamed(context, "/listWine");
        break;
      case "Deletar vinhos":
        Navigator.pushNamed(context, "/deleteWine");
        break;
      case "Adicionar vinhos":
        Navigator.pushNamed(context, "/addWine");
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
        title: Text('TELA INICIAL'),
        centerTitle: true,
        backgroundColor: PaletteColor.icons,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wine_bar,color: PaletteColor.icons,size: 100,
              ),
              ButtonsEnterScreens(
                  text: "Listar Vinhos",
                  onPressed: () => Navigator.pushNamed(context, "/listWine")),
              ButtonsEnterScreens(
                  text: "Cadastrar Vinhos",
                  onPressed: () => Navigator.pushNamed(context, "/addWine")),
              ButtonsEnterScreens(
                  text: "Deletar Vinhos",
                  onPressed: () => Navigator.pushNamed(context, "/deleteWine")),
            ],
          ),
        ),
      ),
    );
  }
}
