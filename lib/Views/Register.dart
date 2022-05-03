import '../../Models/export.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String _error="";

  _signFirebase()async{

    if (_controllerEmail.text.isNotEmpty) {
      setState(() {
        _error = "";
      });

      try{
        await _auth.createUserWithEmailAndPassword(
            email: _controllerEmail.text,
            password: _controllerPassword.text
        ).then((auth)async{
         Future.delayed(Duration.zero,(){
           print("logado");

           db.collection("users").doc(auth.user?.uid).set({
             "id" : auth.user?.uid,
             "name" : _controllerName.text,
             "email" :_controllerEmail.text

           }).then((value){
               showDialog(
                   context: context,
                   barrierDismissible: false,
                   builder: (context) {
                     return ShowDialog(
                       title: 'Usuário Cadastrado',
                       list: [
                         Buttons(
                             onTap: (){
                               setState(() {
                                 Navigator.pushReplacementNamed(context, "/home");
                               });
                             },
                             text: 'OK',
                             color: PaletteColor.icons),
                       ],
                     );
                   });
           });

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
        title: Text('CADASTRO'),
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
                controller: _controllerName,
                hint: 'Informe seu nome',
                fonts: 14,
                keyboardType: TextInputType.emailAddress,
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
                  onTap: ()=>Navigator.pushNamed(context, "/login"),
                  child: Text('Já tenho conta. Entrar')
              ),
              Text(_error,style: TextStyle(color: Colors.red),)
            ],
          ),
        ),
      ),
    );
  }
}
