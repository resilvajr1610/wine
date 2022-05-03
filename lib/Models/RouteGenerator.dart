import '../Models/export.dart';

class RouteGenerator{
    static Route<dynamic>? generateRoute(RouteSettings settings){

      switch(settings.name){
        case "/" :
        return MaterialPageRoute(
            builder: (_) => Home()
        );
        case "/home" :
          return MaterialPageRoute(
              builder: (_) => Home()
          );
        case "/listWine" :
          return MaterialPageRoute(
              builder: (_) => ListWine()
          );
        case "/login" :
          return MaterialPageRoute(
              builder: (_) => Login()
          );
        case "/register" :
          return MaterialPageRoute(
              builder: (_) => Register()
          );
        case "/addWine" :
          return MaterialPageRoute(
              builder: (_) => AddWine()
          );
        case "/deleteWine" :
          return MaterialPageRoute(
              builder: (_) => DeleteWine()
          );

        default :
          _erroRota();
      }
    }
    static  Route <dynamic> _erroRota(){
      return MaterialPageRoute(
          builder:(_){
            return Scaffold(
              appBar: AppBar(
                title: Text("Tela em desenvolvimento"),
              ),
              body: Center(
                child: Text("Tela em desenvolvimento"),
              ),
            );
          });
    }
  }