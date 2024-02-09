import 'package:fluent_ui/fluent_ui.dart';

class Navigate {
  static forward(context, page) {
    Navigator.push(context, FluentPageRoute(builder: ((context) {
      return page;
    })));
  }

  static forwardForever(context, page) {
    Navigator.pushAndRemoveUntil(context,
        FluentPageRoute(builder: ((context) {
      return page;
    })), (route) => false);
  }

  static back(context) {
    Navigator.pop(context);
  }
}
