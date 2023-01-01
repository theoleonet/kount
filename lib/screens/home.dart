import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:kount/screens/auth/auth_state.dart';
import 'package:kount/screens/cards/countdown_card.dart';
import 'package:kount/screens/partials/navbar.dart';
import 'package:kount/screens/partials/top_navbar.dart';
import 'package:kount/screens/styles/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List? countdowns;

  @override
  void initState() {
    AuthState state = AuthState();
    Account account = state.account;
    Databases databases = state.databases;

    Future result = account.get();

    result.then((response) {
      Future result = databases.listDocuments(
        databaseId: '63af4631caad4e759e6e',
        collectionId: '63af48604cb294dfe0b2',
        queries: [
          Query.equal('user_id', response.$id),
        ],
      );

      result.then((response) {
        countdowns = response.documents;
        setState(() {});
      }).catchError((error) {
        print(error);
      });
    }).catchError((error) {
      print(error.response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: TopNavBar(
        title: 'Home',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              countdowns != null
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: countdowns!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final countdown = countdowns![index].data;
                        return CountdownCard(
                          title: countdown['title'],
                          date: countdown['date'],
                          unsplash_url: countdown['unsplash_url'],
                          galery_image_id: countdown['galery_image_id'],
                          color: countdown['color'],
                        );
                      },
                    )
                  : Container()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
