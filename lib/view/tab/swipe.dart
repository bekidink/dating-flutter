import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date/global.dart';
import 'package:date/view/chat/chat_page.dart';
import 'package:date/view/tab/user_detail.dart';
import 'package:date/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../services/swipe_content.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});
  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  late ProfileController profileController;
  String senderName = "";
  bool favorite = false;
  String receiverToken = '';
  // ignore: prefer_final_fields
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  bool _stackFinished = false;
  readCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((dataSnapshot) {
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
        print(senderName);
      });
      buildSwipeItems();
    });
  }

  void buildSwipeItems() {
    _swipeItems.clear();

    for (final eachProfileInfo in profileController.allUsersProfileList) {
      _swipeItems.add(SwipeItem(
          content: Content(
            name: eachProfileInfo.name.toString(),
            imageURL: eachProfileInfo.imageProfile.toString(),
            age: eachProfileInfo.age.toString(),
            bio: eachProfileInfo.bio.toString(),
            uid: eachProfileInfo.uid.toString(),
          ),
          likeAction: () async {
            await retriveReceiver(eachProfileInfo.uid.toString());
            profileController.likeSentAndFavoriteReceived(
                eachProfileInfo.uid.toString(), senderName, receiverToken);
          },
          nopeAction: () {},
          superlikeAction: () async {
            await retriveReceiver(eachProfileInfo.uid.toString());
            profileController.favoriteSentAndFavoriteReceived(
                eachProfileInfo.uid.toString(), senderName, receiverToken);
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    setState(() {}); // Trigger rebuild after building swipe items
  }

  retriveReceiver(String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((dataSnapshot) {
      setState(() {
        receiverToken = dataSnapshot.data()!['userDeviceToken'].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController = Get.put(ProfileController());
    print(profileController.allUsersProfileList.length);

    readCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Habesha",
                style: TextStyle(color: Colors.pink, fontSize: 17),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "dating",
                    style: TextStyle(color: Colors.pink, fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
          actions: [],
        ),
        body: Container(
            child: Stack(children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            margin: EdgeInsetsDirectional.only(
              bottom: 25,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SwipeCards(
              matchEngine: MatchEngine(swipeItems: _swipeItems),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                        left: 0,
                        top: 0.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      _swipeItems[index].content.imageURL),
                                  fit: BoxFit.cover)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                GestureDetector(
                                    onTap: () async {},
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                _swipeItems[index]
                                                    .content
                                                    .name
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    letterSpacing: 4,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                _swipeItems[index]
                                                    .content
                                                    .age
                                                    .toString(),
                                                // eachProfileInfo.city.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    letterSpacing: 4,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.white30,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16))),
                                              child: Text(
                                                _swipeItems[index]
                                                    .content
                                                    .bio
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              )),
                                        ]))
                              ],
                            ),
                          ),
                        ))
                  ],
                );
              },
              onStackFinished: () {
                setState(() {
                  _stackFinished = true;
                });
              },
              itemChanged: (SwipeItem item, int index) {
                print("item: ${item.content.name}, index: $index");
              },
              leftSwipeAllowed: true,
              rightSwipeAllowed: true,
              upSwipeAllowed: true,
              fillSpace: true,
              likeTag: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                child: Icon(
                  Icons.star,
                  color: Colors.red,
                ),
              ),
              nopeTag: Container(
                margin: const EdgeInsets.all(15.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                child: Text('Nope'),
              ),
              superLikeTag: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.orange)),
                child: Text('Super Like'),
              ),
            ),
          ),
          Visibility(
            visible: _stackFinished,
            child: Center(
              child: Text(
                "Stack Finished",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.2),
                            blurRadius: 1,
                            spreadRadius: 4)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                      onTap: () {
                        _matchEngine!.currentItem?.nope();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 40,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 4,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                      onTap: () {
                        _matchEngine!.currentItem?.superLike();
                      },
                      child: Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 40,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 4,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                      onTap: () {
                        _matchEngine!.currentItem?.like();
                      },
                      child: Icon(
                        Icons.star,
                        color: Colors.pink,
                        size: 40,
                      )),
                )
              ],
            ),
          )
        ])));
  }
}
