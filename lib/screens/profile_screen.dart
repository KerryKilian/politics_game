import 'package:flutter/material.dart';
import 'package:politics_game/objects/constants.dart';
import 'package:politics_game/resources/auth_methods.dart';
import 'package:politics_game/screens/profile/description_tab.dart';
import 'package:politics_game/screens/profile/demonstrations_tab.dart';
import 'package:politics_game/screens/profile/questions_tab.dart';
import 'package:politics_game/screens/start/start_screen.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/utils/utils.dart';
import 'package:politics_game/widgets/background.dart';
import 'package:politics_game/widgets/custom_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  late final TabController _tabController =
      TabController(length: 4, vsync: this);
  var userData = {};
  String politicalOrientationOutput = "Mittig";
  String politicalExtremismOutput = "Gemäßigt";
  int following = 0;
  int followers = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();


      userData = userSnap.data()!;
      followers = userSnap.data()!["followers"].length;
      following = userSnap.data()!["following"].length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }

    // Check for political Orientation
    int politicalOrientation = userData["politicalOrientation"];
    if (politicalOrientation < 15) {
      politicalOrientationOutput = Constants.politicalOrientation[0];
    } else if (politicalOrientation >= 15 && politicalOrientation < 30) {
      politicalOrientationOutput = Constants.politicalOrientation[1];
    } else if (politicalOrientation >= 30 && politicalOrientation < 45) {
      politicalOrientationOutput = Constants.politicalOrientation[2];
    } else if (politicalOrientation >= 45 && politicalOrientation < 55) {
      politicalOrientationOutput = Constants.politicalOrientation[3];
    } else if (politicalOrientation >= 55 && politicalOrientation < 70) {
      politicalOrientationOutput = Constants.politicalOrientation[4];
    } else if (politicalOrientation >= 70 && politicalOrientation < 85) {
      politicalOrientationOutput = Constants.politicalOrientation[5];
    } else {
      politicalOrientationOutput = Constants.politicalOrientation[6];
    }

    // Check for political Extremism
    int politicalExtremism = userData["politicalExtremism"];
    if (politicalExtremism < 5) {
      politicalExtremismOutput = Constants.politicalExtremism[0];
    } else if (politicalExtremism >= 5 && politicalExtremism < 15) {
      politicalExtremismOutput = Constants.politicalExtremism[1];
    } else {
      politicalExtremismOutput = Constants.politicalExtremism[2];
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Background(
            child: Center(
            child: CircularProgressIndicator(color: fourthColor,),
          ))
        : Scaffold(
            body: SafeArea(
              child: Background(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: "Mein Profil",
                            title: true,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomButton(
                              text: "Ausloggen",
                              onTapFunction: () {
                                AuthMethods().signOut();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => StartScreen()));
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1661956601031-4cf09efadfce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2376&q=80"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/Sozialdemokratische_Partei_Deutschlands%2C_Logo_um_2000.svg/1000px-Sozialdemokratische_Partei_Deutschlands%2C_Logo_um_2000.svg.png",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: userData["username"]),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(text: "Partei"),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                  text: Constants
                                      .partyAffiliation[userData["level"]]),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(text: "Hat $followers Anhänger"),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(text: "Folgt $followers Personen"),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                  text: "Ausrichtung: " +
                                      politicalOrientationOutput),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(text: politicalExtremismOutput),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(
                            child: Icon(Icons.account_box),
                          ),
                          Tab(
                            child: Icon(Icons.question_answer),
                          ),
                          Tab(
                            child: Icon(Icons.flash_on),
                          ),
                          Tab(child: Icon(Icons.question_mark)),
                        ],
                      ),
                      Expanded(
                        child: Navigator(
                          key: _navKey,
                          onGenerateRoute: (_) => MaterialPageRoute(
                            builder: (_) => TabBarView(
                              controller: _tabController,
                              children: [
                                DescriptionTab(
                                  snap: userData,
                                  party: false,
                                ),
                                CustomText(text: "text"),
                                DemonstrationsTab(
                                  userData: userData,
                                ),
                                QuestionsTab(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
