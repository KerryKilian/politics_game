import 'package:flutter/material.dart';
import 'package:politics_game/screens/parties/found_party_screen.dart';
import 'package:politics_game/screens/parties/party_card.dart';
import 'package:politics_game/widgets/background.dart';
import 'package:politics_game/widgets/custom_button.dart';
import 'package:politics_game/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartyListScreen extends StatefulWidget {
  const PartyListScreen({Key? key}) : super(key: key);

  @override
  State<PartyListScreen> createState() => _PartyListScreenState();
}

class _PartyListScreenState extends State<PartyListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: "Parteien",
                title: true,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: CustomButton(
                      text: "Partei gründen",
                      onTapFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FoundPartyScreen()));
                      })),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("parties")
                    .orderBy("name", descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => PartyCard(snap: snapshot.data!.docs[index]),
                    reverse: false,
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
