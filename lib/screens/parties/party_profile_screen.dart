import 'package:flutter/material.dart';
import 'package:politics_game/screens/profile/description_tab.dart';
import 'package:politics_game/widgets/background.dart';
import 'package:politics_game/widgets/custom_icon_button.dart';
import 'package:politics_game/widgets/custom_text.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class PartyProfileScreen extends StatefulWidget {
  final snap;

  const PartyProfileScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<PartyProfileScreen> createState() => _PartyProfileScreenState();
}

class _PartyProfileScreenState extends State<PartyProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context) {
    int memberCount = (widget.snap["members"] as List).length;

    return Scaffold(
      body: SafeArea(
        child: Background(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: CustomIconButton(
                          icon: Icons.arrow_back,
                          onTap: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: widget.snap["name"],
                            title: true,
                            maxLines: 2,
                            softWrap: true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: widget.snap["shortName"],
                            title: true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: widget.snap["slogan"],
                            maxLines: 2,
                            softWrap: true,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          widget.snap["photoUrl"],
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: "$memberCount " +
                            (memberCount != 1 ? "Mitglieder" : "Mitglied"),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
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
                          DescriptionTab(snap: widget.snap, party: true),
                          CustomText(text: "text"),
                          CustomText(text: "text"),
                          CustomText(text: "text"),
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
