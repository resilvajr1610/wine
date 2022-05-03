import '../Models/export.dart';

class ButtonsEnterScreens extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  ButtonsEnterScreens({
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        color:PaletteColor.inputs,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: width,
          child: TextButton(
            child: Text(this.text,
                style: TextStyle(
                  fontSize: 20,
                  color: PaletteColor.icons,
                  fontWeight: FontWeight.w400,
                )),
            style: TextButton.styleFrom(
            ),
            onPressed: this.onPressed,
          ),
        ),
      ),
    );
  }
}
