import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:signup_login/homepage.dart';
import 'package:signup_login/reusable_code/colors.dart';
import 'package:signup_login/reusable_code/constants.dart';
import 'package:signup_login/reusable_code/custom_button.dart';
import 'package:signup_login/reusable_code/validation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUpPageWidget extends StatefulWidget {
  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  late String email;
  late String pswd;
  bool visibility = false;
  bool hiddenText = true;

  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pswdController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  _signUp(String name, String email, String contact, String pswd,
      BuildContext context) async {
    try {
      UserCredential newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pswd);

      await FirebaseFirestore.instance
          .collection('registration')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'email': email,
        'Username': name,
        'contact': contact,
        'password': pswd,
        // 'uid': newUser.user!.uid
      }).then((val) async{

        // SharedPreferences.setMockInitialValues({});
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('uid', newUser.user!.uid);
        prefs.setString('email', email);
        print('***shared prefs code ***');
         Get.off(const Dashboard());

      }).catchError((e){
        print("Koi to Error hai babua : " + e.toString());
      }).whenComplete(() async{


        print("Successfully added in database");
        if (newUser != null) {

          // Get.off( const Dashboard());


          // Not needed ;)
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const Dashboard(),
          //   ),
          //   (route) => route.isFirst,
          // );
        }
      });
    } catch (e) {
      print("Registration Failed $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: textColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Stack(
                        children: const [
                          CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1525134479668-1bee5c7c6845?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                              radius: 50),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: textColor,
                              child: Icon(
                                Icons.edit,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      const Text(
                        "Create Account",
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
                          controller: _userController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.only(top:10),
                            prefixIcon: Icon(
                              Icons.person,
                              color: textColor,
                            ),
                            labelText: 'Username',
                            labelStyle: TextStyle(color: textColor),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Username";
                            } else if (!RegExp(userValidation)
                                .hasMatch(value)) {
                              return "Not Valid Name";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: textColor,
                          ),
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.email, color: textColor),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: textColor),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Email";
                            } else {
                              if (!RegExp(emailValidation).hasMatch(value)) {
                                return "Invalid email id";
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: textColor,
                          ),
                        ),
                        child: TextFormField(
                          controller: _contactController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.phone, color: textColor),
                            labelText: 'Phone',
                            labelStyle: TextStyle(color: textColor),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(phoneValidation))
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter phone number";
                            } else if (value.length != 10) {
                              // print(value.length);
                              return "Contact number should be of 10 characters";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: textColor,
                          ),
                        ),
                        child: TextFormField(
                          obscureText: hiddenText,
                          controller: _pswdController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                const Icon(Icons.password, color: textColor),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibility = !visibility;
                                  if (visibility) {
                                    hiddenText = false;
                                  } else {
                                    hiddenText = true;
                                  }
                                });
                              },
                              icon: visibility
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
                            labelStyle: const TextStyle(color: textColor),
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
                            _signUp(
                                _userController.text,
                                _emailController.text,
                                _contactController.text,
                                _pswdController.text,
                                context);
                          }
                        },
                        name: 'Create Account',
                        style: elevatedButtonStyle.copyWith(
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
