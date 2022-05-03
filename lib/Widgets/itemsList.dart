import '../Models/export.dart';

class ItemsList extends StatelessWidget {

  final String wine;
  final int since;
  final String type;
  final bool showIconDelete;
  VoidCallback onPressed;

  ItemsList({
    required this.wine,
    required this.since,
    required this.type,
    required this.onPressed,
    required this.showIconDelete
});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return InkWell(
      child: Container(
        height: 75,
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vinho : "+this.wine,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    color: PaletteColor.icons,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Ano : "+this.since.toString(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    color: PaletteColor.icons,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Tipo : "+this.type,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    color: PaletteColor.icons,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Spacer(),
            this.showIconDelete?IconButton(
              icon: Icon(Icons.delete,color: PaletteColor.icons),
              onPressed: this.onPressed,
            ):Container()
          ],
        ),
      ),
    );
  }
}
