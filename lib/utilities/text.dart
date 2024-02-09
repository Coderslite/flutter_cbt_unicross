import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';

class MyText extends StatelessWidget {
  final Color color;
  final int size;
  final String text;
  const MyText({
    super.key,
    required this.color,
    required this.size,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.metrophobic(
          fontSize: size.toDouble(), color: color, fontWeight: FontWeight.w500),
    );
  }
}
