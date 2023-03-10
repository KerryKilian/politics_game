import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:politics_game/resources/auth_methods.dart';
import 'package:politics_game/responsive/mobile_screen_layout.dart';
import 'package:politics_game/responsive/responsive_layout_screen.dart';
import 'package:politics_game/responsive/web_screen_layout.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/utils/utils.dart';
import 'package:politics_game/widgets/background.dart';
import 'package:politics_game/widgets/custom_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:politics_game/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        file: _image!);
    setState(() {
      _isLoading = false;
    });
    
    if (res != "success") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout())));

    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
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
                  CustomText(text: "Registrieren", title: true,),
                  SizedBox(height: 20,),
                  CustomText(
                      text: "Registriere dich jetzt kostenlos, um zu spielen."),
                  SizedBox(height: 20,),
                  TextFieldInput(textEditingController: _usernameController,
                    text: "Benutzername",
                    textInputType: TextInputType.text,),
                  SizedBox(height: 20,),
                  TextFieldInput(textEditingController: _emailController,
                      text: "Email",
                      textInputType: TextInputType.emailAddress),
                  SizedBox(height: 20,),
                  TextFieldInput(textEditingController: _passwordController,
                    text: "Passwort",
                    textInputType: TextInputType.visiblePassword,
                  obscureText: true,),
                  SizedBox(height: 20,),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                        radius: 64,

                        backgroundImage: MemoryImage(_image!),
                      )
                          : CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            "https://as1.ftcdn.net/v2/jpg/00/64/67/80/1000_F_64678017_zUpiZFjj04cnLri7oADnyMH0XBYyQghG.jpg"),
                      ),
                      Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: const Icon(
                              Icons.add_a_photo, color: primaryColor,),
                          )),
                    ],
                  ),
                  SizedBox(height: 20,),

                  CustomButton(text: "Bestätigen", onTapFunction: signUpUser,),
                ],
              ),
            ),
          ),
        )
    );
  }
}
