import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signup_login/homepage.dart';
import 'package:signup_login/reusable_code/colors.dart';
import 'package:signup_login/reusable_code/constants.dart';
import 'package:signup_login/reusable_code/custom_button.dart';
import 'package:signup_login/reusable_code/validation.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController noController = TextEditingController();
  TextEditingController pswdController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  _editProfile(String username, String email, String contact, String password,
      BuildContext context) async {
    try {
      print("$username, $email, $contact, $password");
      await FirebaseAuth.instance.currentUser?.updateEmail(email);
      // await document.reference.updateData()

      await FirebaseFirestore.instance
          .collection('registration')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'Username': username,
        'email': email,
        'contact': contact,
        'password': password,
      }).then(
        (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ),
          );
        },
      ).catchError((e) {
        print("kuch to gadbad hai babu mosai $e");
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Profile Updated")));
    } catch (e) {
      print("Registration Failed $e");
    }
  }
  void getData() async {
    FirebaseFirestore.instance
        .collection('registration')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      print(value.id);
      if (value.exists) {
        Map<String, dynamic>? data = await value.data();
        setState(() {
          userController.text = data?['Username']!;
          pswdController.text = data?['password'];
          emailController.text = data?['email'];
          noController.text = data?['contact'];
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error Facthing value $value")));
      }
    });
  }

  String? uid = null;
  String? mailid = '';

  // getbackgroundData() {
  //   setState(() async{
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     uid = preferences.getString('uid');
  //     mailid = preferences.getString('email');
  //     print("uid stored in background is " + uid!);
  //     // FirebaseFirestore.instance.collection('registration').doc(uid).snapshots();
  //   });
  // }

  @override
  void initState() {
    getData();
    // getbackgroundData();
    super.initState();
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
                      const Stack(
                        children: [
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
                        "Edit Profile",
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
                          controller: userController,
                          // initialValue: snapshot.data["Username"],
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
                          controller: emailController,
                          // initialValue: snapshot.data["email"],
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
                          controller: noController,
                          // initialValue: snapshot.data["contact"],
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
                          controller: pswdController,
                          readOnly: true,
                          // initialValue: snapshot.data["password"],
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.password, color: textColor),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: textColor),
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
                          print("Data:");
                          _editProfile(
                              userController.text,
                              emailController.text,
                              noController.text,
                              pswdController.text,
                              context);
                        },
                        name: 'Edit',
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
