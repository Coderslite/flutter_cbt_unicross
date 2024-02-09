import 'package:bot_toast/bot_toast.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/controllers/login_controller.dart';
import 'package:unicross_cbt_desktop_app/utilities/color.dart';

import '../../utilities/text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  String username = '';
  String password = '';
  bool obscure = true;

  @override
  void initState() {
    // RawKeyboard.instance.addListener(_handleKeyEvents);
    super.initState();
  }

  // @override
  // void dispose() {
  //   RawKeyboard.instance.removeListener(_handleKeyEvents);

  //   super.dispose();
  // }

  // _handleKeyEvents(RawKeyEvent event) {
  //   print(event);
  //   if (event.logicalKey == LogicalKeyboardKey.metaLeft) {
  //     BotToast.showSimpleNotification(title: "Do not go outside this screen");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // var heightSize = MediaQuery.of(context).size.height;
    var widthSize = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(
          child: Container(
            color: white,
            width: widthSize / 2,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      "assets/images/logo.png",
                    )),
                const SizedBox(
                  height: 10,
                ),
                MyText(
                    color: black!, size: 27, text: "Welcome to Unicross CBT"),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyText(color: blue2, size: 33, text: "Guidelines"),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                        color: black!,
                        size: 20,
                        text: "* Do not use any networked device(phone,watch)"),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                        color: black!,
                        size: 20,
                        text: "* Do not disturb the environment"),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              // color: blue2,
              decoration: const BoxDecoration(
                color: blue2,
                image: DecorationImage(
                  // opacity: 0.07,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/bg.png"),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyText(
                    text: "LOGIN",
                    color: white,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextBox(
                    padding: const EdgeInsets.all(12),
                    placeholder: "Username",
                    style: TextStyle(color: black),
                    onChanged: (value) {
                      username = value.toString();
                    },
                    // decoration: InputDecoration(
                    //   enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: white!)),
                    //   label: Text(
                    //     "username",
                    //     style: TextStyle(color: white),
                    //   ),
                    // ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextBox(
                    obscureText: obscure,
                    padding: const EdgeInsets.all(12),
                    placeholder: "Password",
                    suffix: IconButton(
                        icon: Icon(FluentIcons.password_field),
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        }),
                    style: TextStyle(color: black),
                    onChanged: (value) {
                      password = value.toString();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: widthSize * 0.99,
                    height: 55,
                    child: Button(
                        onPressed: () {
                          BotToast.showLoading();
                          Future.delayed(const Duration(seconds: 3))
                              .then((value) {
                            BotToast.closeAllLoading();
                            loginController.handleLogin(
                                context, username, password);
                          });
                        },
                        style:
                            ButtonStyle(backgroundColor: ButtonState.all(blue)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: MyText(color: white, size: 18, text: "LOGIN"),
                        )),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
