import 'package:flutter/material.dart';
import 'package:politics_game/objects/constants.dart';
import 'package:politics_game/resources/auth_methods.dart';
import 'package:politics_game/screens/profile/demonstrations_tab.dart';
import 'package:politics_game/screens/profile/description_tab.dart';
import 'package:politics_game/screens/profile/questions_tab.dart';
import 'package:politics_game/screens/start/start_screen.dart';
import 'package:politics_game/utils/colors.dart';
import 'package:politics_game/utils/utils.dart';
import 'package:politics_game/widgets/background.dart';
import 'package:politics_game/widgets/custom_button.dart';
import 'package:politics_game/widgets/custom_icon_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tinycolor2/tinycolor2.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class PartyProfileScreen extends StatefulWidget {
  final snap;

  const PartyProfileScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<PartyProfileScreen> createState() => _PartyProfileScreenState();
}

class _PartyProfileScreenState extends State<PartyProfileScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  late final TabController _tabController =
      TabController(length: 4, vsync: this);
  String politicalOrientationOutput = "Mittig";
  String politicalExtremismOutput = "Gemäßigt";
  Color textColor = primaryColor;

  @override
  void initState() {
    super.initState();
    Color backgroundColor = Color(int.parse('FF${widget.snap["color"]}', radix: 16));
    if (TinyColor.fromColor(backgroundColor).isDark()) {
      textColor = Colors.black;
    }
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      // var widget.snap = await FirebaseFirestore.instance
      //     .collection("parties")
      //     .doc(widget.snap["partyId"])
      //     .get();

      // widget.snap = widget.snap.data()!;
      // followers = widget.snap["followers"].length;
      // following = widget.snap["following"].length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }

    // Check for political Orientation
    int politicalOrientation = widget.snap["politicalOrientation"];
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
    int politicalExtremism = widget.snap["politicalExtremism"];
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
    Color partyColor = Color(int.parse('FF${widget.snap["color"]}', radix: 16));
    int memberCount = (widget.snap["members"] as List).length;
    return isLoading
        ? const Background(
            child: Center(
            child: CircularProgressIndicator(
              color: fourthColor,
            ),
          ))
        : Scaffold(
            body: SafeArea(
              child: Background(
                colorOne: TinyColor.fromColor(partyColor).spin(50).color,
                colorTwo: partyColor,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomIconButton(
                            icon: Icons.arrow_back,
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomText(
                              text: "${widget.snap["name"]}",
                              title: true,
                              textAlign: TextAlign.left,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 100,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      widget.snap["photoUrl"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.short_text,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(text: widget.snap["shortName"]),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.feedback_outlined,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(child: CustomText(text: widget.snap["slogan"], softWrap: true,)),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.work_outline,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text: Constants
                                            .partyLevels[widget.snap["level"]]),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.group_outlined,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(text: memberCount.toString()),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.swap_horiz_outlined,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(text: politicalOrientationOutput),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.balance_outlined,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(text: politicalExtremismOutput),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                        text:
                                            "${DateFormat.yMMMd().format(widget.snap["foundingDate"].toDate())}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
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
                                  snap: widget.snap,
                                  party: true,
                                ),
                                CustomText(text: "text"),
                                DemonstrationsTab(
                                  userData: widget.snap,
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
