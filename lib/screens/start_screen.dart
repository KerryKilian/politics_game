import 'package:flutter/material.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/widgets/background.dart';
import 'package:politics_game/widgets/custom_button.dart';
import 'package:politics_game/widgets/custom_text.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, children: [
              CustomText(
              text: "Hast du das Zeug zum Kanzler oder zur Kanzlerin?",
              title: true,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: CustomText(
                  text:
                  "Bulin-Polit ist ein Simulationsspiel, bei dem du dich für eine Partei an die Spitze der bulinischen Politik bringen musst. Überzeuge andere Mitspieler von deiner Meinung und hole Stimmen aus dem Volk"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 80, right: 80),
              child: CustomButton(
                  text: "Einloggen",
                  onTapFunction: () {},
            )
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 80, right: 80),
          child: CustomButton(text: "Registrieren", onTapFunction: () {},),
        )
        ]),)
    ,
    );
  }
}
