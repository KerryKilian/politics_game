import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:politics_game/utils/colors.dart";
import "package:politics_game/utils/global_variables.dart";

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        body: PageView(
          children: homeScreenItems,
          physics: NeverScrollableScrollPhysics(),
          // no scroll effect when scrolling left or right
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: Stack(
          children: [
            Container(
              // this is the decoration of the container for gradient look
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    fourthColor,
                    fifthColor,
                  ],
                ),
              ),
              // i have found out the height of the bottom navigation bar is roughly 60
              height: 60,
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: CupertinoTabBar(
                backgroundColor: Colors.transparent,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: _page == 0 ? primaryColor : secondaryColor,
                      ),
                      label: "",
                      backgroundColor: primaryColor),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                        color: _page == 1 ? primaryColor : secondaryColor,
                      ),
                      label: "",
                      backgroundColor: primaryColor),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.add_circle,
                        color: _page == 2 ? primaryColor : secondaryColor,
                      ),
                      label: "",
                      backgroundColor: primaryColor),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite,
                        color: _page == 3 ? primaryColor : secondaryColor,
                      ),
                      label: "",
                      backgroundColor: primaryColor),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        color: _page == 4 ? primaryColor : secondaryColor,
                      ),
                      label: "",
                      backgroundColor: primaryColor),
                ],
                onTap: navigationTapped,
              ),
            ),
          ],
        ));
  }
}
