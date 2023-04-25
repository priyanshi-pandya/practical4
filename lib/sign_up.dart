import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signup_login/homepage.dart';
import 'package:signup_login/reusable_code/constants.dart';
import 'package:signup_login/reusable_code/custom_button.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({Key? key}) : super(key: key);

  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  final formKey = GlobalKey<FormState>();

  bool visibility = false;
  bool hiddenText = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },

      child: SafeArea(
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
                            color: Color(0xff212A3E),
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
                              backgroundColor: Color(0xff212A3E),
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
                            color: Color(0xff212A3E),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'LibreBarnesville'),
                      ),

                      SizedBox(
                        height: height * 0.05,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff212A3E),),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.only(top:10),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color(0xff212A3E),
                            ),
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Color(0xff212A3E)),
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
                        height: height * 0.01,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff212A3E),),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.email, color: Color(0xff212A3E)),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Color(0xff212A3E)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Email";
                            } else {
                              if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+").hasMatch(value)) {
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
                          border: Border.all(color: const Color(0xff212A3E),),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.phone, color: Color(0xff212A3E)),
                            labelText: 'Phone',
                            labelStyle: TextStyle(color: Color(0xff212A3E)),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter phone number";
                            } else if(value.length != 10){
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
                          border: Border.all(color: const Color(0xff212A3E),),
                        ),
                        child: TextFormField(
                          obscureText: hiddenText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                            const Icon(Icons.password, color: Color(0xff212A3E)),
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
                                color: Color(0xff212A3E),
                              )
                                  : const Icon(
                                Icons.visibility_off,
                                color: Color(0xff212A3E),
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Color(0xff212A3E)),
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
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Dashboard(),), (route) => route.isFirst,);
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
