import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signup_login/homepage.dart';
import 'package:signup_login/reusable_code/constants.dart';
import 'package:signup_login/reusable_code/custom_button.dart';
import 'package:signup_login/sign_up.dart';

void main() {
  runApp(const MaterialApp(
    title: "My Page",
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool visible = false;
  bool hiddenText = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/images/wallpaper.jpg'),
              fit: BoxFit.cover,
              opacity: 0.6,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 25.0, right: 25, top: height * 0.08),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1525134479668-1bee5c7c6845?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                      radius: 50,
                    ),

                    SizedBox(
                      height: height * 0.05,
                    ),

                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff212A3E),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LibreBarnesville'),
                    ),

                    SizedBox(
                      height: height * 0.05,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff212A3E),
                        ),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff212A3E),
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Color(0xff212A3E),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Username";
                          } else if (!RegExp(r'^[a-zA-z]+$').hasMatch(value)) {
                            return "Not Valid Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    SizedBox(
                      height: height * 0.015,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff212A3E),
                        ),
                      ),
                      child: TextFormField(
                        obscureText: hiddenText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.password,
                              color: Color(0xff212A3E)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                                if (visible) {
                                  hiddenText = false;
                                } else {
                                  hiddenText = true;
                                }
                              });
                            },
                            icon: visible
                                ? const Icon(
                                    Icons.visibility,
                                    color: Color(0xff212A3E),
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Color(0xff212A3E),
                                  ),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            color: Color(0xff212A3E),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter password";
                          } else {
                            if (value.length < 6) {
                              return "Minimum 6 length is Required";
                            } else {
                              return null;
                            }
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                        ],
                      ),
                    ),

                    SizedBox(
                      height: height * 0.05,
                    ),

                    CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Dashboard(),
                            ),
                          );
                        }
                      },
                      name: 'Get Started',
                      style: elevatedButtonStyle.copyWith(
                        minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.05,
                    ),

                    const Center(
                      child: Text(
                        "Or",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff212A3E),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.04,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('asset/images/google.png'),
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                        InkWell(
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('asset/images/apple.png'),
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                        InkWell(
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('asset/images/facebook.png'),
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),

                    SizedBox(
                      height: height * 0.04,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPageWidget(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color(0xff212A3E), fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
