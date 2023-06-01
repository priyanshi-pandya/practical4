import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_login/reusable_code/validation.dart';
import 'package:signup_login/view/authentication/sign_up.dart';
import '../../homepage.dart';
import '../../reusable_code/colors.dart';
import '../../reusable_code/constants.dart';
import '../../reusable_code/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool visible = false;
  bool hiddenText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();

  storeBackgroundData(uid,email) async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
    prefs.setString('email',email);

  }
  _loginCredential(String email, String pswd, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pswd)
          .then((value) {

        value != null
            ? {
                FirebaseFirestore.instance
                    .collection('registration')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
          storeBackgroundData(FirebaseAuth.instance.currentUser!.uid,email),
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Logged in"),
                  ),
                ),
                Get.to(const Dashboard())
              }
            : ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Error"),
                ),


              );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User doesn't exist"),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password did not matched"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LibreBarnesville'),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: textColor,
                        ),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: textColor,
                          ),
                          labelText: 'Email address',
                          labelStyle: TextStyle(
                            color: textColor,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter EmailAddress";
                          } else if (!RegExp(emailValidation).hasMatch(value)) {
                            return "Not Valid EmailId";
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
                          color: textColor,
                        ),
                      ),
                      child: TextFormField(
                        controller: pswdController,
                        obscureText: hiddenText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon:
                              const Icon(Icons.password, color: textColor),
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
                                    color: textColor,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: textColor,
                                  ),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            color: textColor,
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
                          _loginCredential(emailController.text,
                              pswdController.text, context);
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
                          color: textColor,
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
                                builder: (context) =>  SignUpPageWidget(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: textColor, fontSize: 15),
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
