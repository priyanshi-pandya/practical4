import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool createQuote = false;
  int quotesIndex = 0;
  List quotes = [
    "A few bad chapters do not mean your story is over.",
    "Every new day brings with it another chance to change a life.",
    "Don’t make excuses, make improvements.",
    "Do one thing every day that scares you.",
    "If an opportunity does not knock, build a door."
  ];

  TextEditingController createQuoteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/images/wallpaper.jpg'),
                fit: BoxFit.cover,
                opacity: 0.8),
          ),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (createQuote == false)
                GestureDetector(
                  onDoubleTap: () {
                    // print("favourite");
                  },
                  onHorizontalDragEnd: ((details) {
                    if (details.velocity.pixelsPerSecond.dx < 1) {
                      // print("right swipe");
                      var b = quotes.length - 1;

                      if (quotesIndex < b) {
                        setState(() {
                          quotesIndex++;
                        });
                      }
                    } else {
                      // print('left swipe');
                      if (quotesIndex >= 1) {
                        setState(() {
                          quotesIndex--;
                        });
                      }
                    }
                  }),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 50,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  color: Color(0xff212A3E),
                                ),
                              ),
                            ),
                            const Text(
                              "Thoughts",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'LibreBarnesville',
                                  fontSize: 30),
                             textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 50,)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 50.0, right: 50.0, top: 10.0),
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          // child: Image.asset("images/background.jpg"),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 30.0),
                                child: Text(
                                  "Motivation",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Color(0xff212A3E),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.3,
                                child: Center(
                                  child: Text(
                                    quotes[quotesIndex],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'LibreBarnesville',
                                      color: Color(0xff212A3E),
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  "Priyanshi",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Color(0xff212A3E),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
                    height: MediaQuery.of(context).size.height * 0.5,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Text(
                                "Motivation",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Color(0xff212A3E),
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
                              style: const TextStyle(color: Color(0xff212A3E)),
                              decoration: const InputDecoration(
                                hintText: "Write your quote here...",
                                border: InputBorder.none,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                "Priyanshi Pandya",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xff212A3E),
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

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "${quotesIndex + 1}/${quotes.length}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ]),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: createQuote == false
            ? FloatingActionButton(
                elevation: 15,
                splashColor: Colors.yellow,
                backgroundColor: const Color(0xff212A3E),
                onPressed: () {
                  setState(() {
                    createQuote = true;
                  });
                },
                child: const Icon(Icons.add),
              )
            : FloatingActionButton(
                elevation: 15,
                splashColor: Colors.yellow,
                backgroundColor: const Color(0xff212A3E),
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
      ),
    );
  }

  void addquote() {
    quotes.add(createQuoteController.text);
    createQuoteController.clear();
    // print(quotes);
  }
}
