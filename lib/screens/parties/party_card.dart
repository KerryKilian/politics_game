import 'package:flutter/material.dart';
import 'package:politics_game/models/party.dart';
import 'package:politics_game/screens/parties/party_profile_screen.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/widgets/custom_text.dart';

class PartyCard extends StatelessWidget {
  final snap;

  const PartyCard({Key? key, required this.snap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int memberCount = (snap["members"] as List).length;

    print("******************************************");
    print(snap["photoUrl"]);
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PartyProfileScreen(snap: snap)));
        },
        child: Row(
          children: [
            Container(
              width: 100,
              margin: EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      snap["photoUrl"],
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Container(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: snap["name"],
                      textAlign: TextAlign.left,
                      softWrap: true,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: snap["slogan"],
                      textAlign: TextAlign.left,
                      softWrap: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CustomText(text: "$memberCount"),
                        SizedBox(width: 5,),
                        Icon(Icons.group, color: primaryColor,)
                      ],
                    ),

                  ],
                )),
          ],
        ),
      ),
    );
  }
}
