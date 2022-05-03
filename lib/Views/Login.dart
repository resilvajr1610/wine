import '../../Models/export.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _error="";

  _signFirebase()async{

    if (_controllerEmail.text.isNotEmpty) {
      setState(() {
        _error = "";
      });

      try{
        await _auth.signInWithEmailAndPassword(
            email: _controllerEmail.text,
            password: _controllerPassword.text
        ).then((auth)async{
         Future.delayed(Duration.zero,(){
           print("logado");
           Navigator.pushReplacementNamed(context, "/home");
         });
        });
      }on FirebaseAuthException catch (e) {
        if(e.code =="unknown"){
          setState(() {
            _error = "A senha está vazia!";
          });
        }else if(e.code =="invalid-email"){
          setState(() {
            _error = "Digite um e-mail válido!";
          });
        }else if(e.code =="email-already-exists"){
          setState(() {
            _error = "E-mail já esta cadastrado!";
          });
        }else{
          setState(() {
            _error = e.code;
          });
        }
      }
    } else {
      setState(() {
        _error = "Preencha seu email";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: PaletteColor.background,
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
        backgroundColor: PaletteColor.icons,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wine_bar,color: PaletteColor.icons,size: 200,
              ),
              SizedBox(height: 10),
              Inputs(
                width: width*0.8,
                obscure: false,
                controller: _controllerEmail,
                hint: 'Informe seu e-mail',
                fonts: 14,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              Inputs(
                width: width*0.8,
                obscure: true,
                controller: _controllerPassword,
                hint: 'Informe sua senha',
                fonts: 14,
                keyboardType: TextInputType.visiblePassword,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Buttons(
                    onTap: ()=>_signFirebase(),
                    text: 'Entrar',
                    color: PaletteColor.icons
                ),
              ),
              GestureDetector(
                onTap: ()=>Navigator.pushNamed(context, "/register"),
                  child: Text('Não tem conta? Cadastre -se')
              ),
              Text(_error,style: TextStyle(color: Colors.red),)
            ],
          ),
        ),
      ),
    );
  }
}
