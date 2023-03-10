import 'package:flutter/material.dart';
import 'package:politics_game/resources/auth_methods.dart';
import 'package:politics_game/responsive/mobile_screen_layout.dart';
import 'package:politics_game/responsive/responsive_layout_screen.dart';
import 'package:politics_game/responsive/web_screen_layout.dart';
import 'package:politics_game/utils/utils.dart';
import 'package:politics_game/widgets/background.dart';
import 'package:politics_game/widgets/custom_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:politics_game/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;


  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
          const ResponsiveLayout(webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout()))
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                CustomText(
                  text: "Login",
                  title: true,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    textEditingController: _emailController,
                    text: "Benutzername",
                    textInputType: TextInputType.emailAddress),
                SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  text: "Password",
                  textInputType: TextInputType.text,
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(text: "Bestätigen", onTapFunction: loginUser),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
