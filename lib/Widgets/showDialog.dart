import '../Models/export.dart';

class ShowDialog extends StatelessWidget {

  final String title;
  final List<Widget> list;

  ShowDialog({
    required this.title,
    required this.list,
});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(this.title)),
      titleTextStyle: TextStyle(color: PaletteColor.icons,fontSize: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      actions: this.list,
    );
  }
}
