import '../Models/export.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:Register(),
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}