import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_login/profile.dart';
import 'package:signup_login/reusable_code/colors.dart';
import 'package:signup_login/view/authentication/login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool createQuote = false;
  int quotesIndex = 0;
  TextEditingController createQuoteController = TextEditingController();
  TextEditingController createQuoteTypeController = TextEditingController();
  late int docLength = 0;
  late String currentUser = "";

  Future<void> getLength() async {
    docLength = await FirebaseFirestore.instance
        .collection("quotes")
        .get()
        .then((snapshot) => snapshot.size);
    print(docLength);
  }

  Future<void> getName() async {
    DocumentSnapshot<Map<String, dynamic>> snap= await FirebaseFirestore.instance
        .collection("registration")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if(snap.exists){
      print("fgdgg");
      Map<String, dynamic>? data = snap.data()!;
      // print(data);
      currentUser = data["Username"];
      // print(currentUser);
    }
  }


  @override
  void initState() {
    super.initState();
    getLength();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('quotes').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/images/wallpaper.jpg'),
                        fit: BoxFit.cover,
                        opacity: 0.8),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (createQuote == false)
                            GestureDetector(
                              // onDoubleTap: () {
                              //   // print("favourite");
                              // },
                              // onHorizontalDragEnd: ((details) {
                              //   if (details.velocity.pixelsPerSecond.dx < 1) {
                              //     // print("right swipe");
                              //     var b = quotes.length - 1;
                              //
                              //     if (quotesIndex < b) {
                              //       setState(() {
                              //         quotesIndex++;
                              //       });
                              //     }
                              //   } else {
                              //     // print('left swipe');
                              //     if (quotesIndex >= 1) {
                              //       setState(() {
                              //         quotesIndex--;
                              //       });
                              //     }
                              //   }
                              // }),

                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          child: IconButton(
                                            onPressed: () async {
                                              FirebaseAuth.instance.signOut();
                                              SharedPreferences preferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await preferences.clear();
                                              Get.off(const LoginPage());
                                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                                            },
                                            icon: const Icon(
                                              Icons.logout,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "Thoughts",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontFamily: 'LibreBarnesville',
                                              fontSize: 30),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          width: 50,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 50.0, right: 50.0, top: 10.0),
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    width: MediaQuery.of(context).size.width,
                                    child: AppinioSwiper(
                                      direction: AppinioSwiperDirection.left,
                                      loop: true,
                                      maxAngle: 30,
                                      onSwipe: (index, left) {
                                        quotesIndex < docLength - 1
                                            ? quotesIndex++
                                            : quotesIndex = 0;
                                      },
                                      cardsBuilder:
                                          (BuildContext context, int index) {
                                        return Card(
                                          elevation: 10,
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          // child: Image.asset("images/background.jpg"),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30.0),
                                                  child: Text(
                                                    snapshot.data.docs[index]
                                                        ['type'],
                                                    style: const TextStyle(
                                                      fontSize: 17.0,
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  child: Center(
                                                    child: Text(
                                                      snapshot.data.docs[index]
                                                          ['quote'],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'LibreBarnesville',
                                                        color: textColor,
                                                        fontSize: 25.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20.0),
                                                  child: Text(
                                                    snapshot.data.docs[index]
                                                        ['author'],
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      cardsCount: docLength,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Center(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 50.0, top: 10.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  // clipBehavior: Clip.antiAlias,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  // child: Padding(
                                  // padding: const EdgeInsets.only(left: 15.0,),
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                         Padding(
                                          padding: const EdgeInsets.only(top: 30.0),
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: createQuoteTypeController,
                                            decoration: const InputDecoration(
                                              hintText: "Motivation",
                                              border: InputBorder.none,
                                            ),
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: textColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: createQuoteController,
                                          textAlign: TextAlign.center,
                                          maxLength: 100,
                                          maxLines: 5,
                                          keyboardType: TextInputType.text,
                                          style:
                                              const TextStyle(color: textColor),
                                          decoration: const InputDecoration(
                                            hintText:
                                                "Write your quote here...",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: Text(
                                            currentUser,
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              color: textColor,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          // )
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 20.0),
                          //   child: Text(
                          //     "${quotesIndex + 1}/$docLength",
                          //     style: const TextStyle(color: Colors.white70),
                          //   ),
                          // ),
                        ]),
                  ),
                ),
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: createQuote == false
          ? FloatingActionButton(
              elevation: 15,
              splashColor: Colors.yellow,
              backgroundColor: Colors.white70,
              onPressed: () {
                setState(() {
                  createQuote = true;
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.black87,
              ),
            )
          : FloatingActionButton(
              elevation: 15,
              splashColor: Colors.yellow,
              backgroundColor: textColor,
              onPressed: () {
                if (createQuoteController.text.isEmpty) {
                  var bb =
                      const SnackBar(content: Text("Please enter a quote"));
                  ScaffoldMessenger.of(context).showSnackBar(bb);
                } else {
                  addquote();
                  setState(() {
                    createQuote = false;
                  });
                }
              },
              child: const Icon(Icons.check),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (index) {
          if (index == 0) {
          } else if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfile(),
                ));
          }
        },
      ),
    );
  }

void addquote() async{
  await FirebaseFirestore.instance.collection('quotes').add({
    'type': createQuoteTypeController.text.trim(),
    'author': currentUser,
    'liked': false,
    'quote': createQuoteController.text.trim(),

  });
}
}
