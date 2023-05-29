// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';
import '../main.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  String _errorMessage = '';

  void _registerUser(String userId, String email, String password,
      String firstName, String lastName) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/register/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userId,
        'email': email,
        'password': password,
        'firstname': firstName,
        'lastname': lastName,
      }),
    );

    if (response.statusCode == 201) {
      // Updated status code check to 201
      Navigator.pop(context);
    } else {
      setState(() {
        _errorMessage = 'Failed to register user';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //image
          Image.asset(
            'assets/images/airlogo.png',
            height: 180,
            width: 410,
          ),
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    SizedBox(height: 16),
                    Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        controller: _firstnameController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          prefixIcon: tProfile,
                          prefixIconColor: tBlack,
                          labelText: 'First Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        controller: _lastnameController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          prefixIcon: tProfile,
                          prefixIconColor: tBlack,
                          labelText: 'Last Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          prefixIcon: tMail,
                          prefixIconColor: tBlack,
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          prefixIcon: tPass2,
                          prefixIconColor: tBlack,
                          labelText: 'Password',
                          hintStyle: TextStyle(
                            color: tWhite,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        controller: _confirmpasswordController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          prefixIcon: tPass2,
                          prefixIconColor: tBlack,
                          labelText: 'Confirm Password',
                          hintStyle: TextStyle(
                            color: tWhite,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter confirmation password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final uuid = Uuid();
                          final userId = uuid.v4();
                          _registerUser(
                              userId,
                              _emailController.text,
                              _passwordController.text,
                              _firstnameController.text,
                              _lastnameController.text);
                        }
                      },
                      child: Text('Sign up'),
                    ),
                    Divider(
                      color: tBlack,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 25,
                      width: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: tWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/google.png',
                                  height: 50,
                                  width: 50,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Register with Google',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 100),
                      child: Row(
                        children: [
                          Text(
                            "Already Registered?",
                            style: TextStyle(
                              fontSize: 10,
                              color: tBlack,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const MyApp()));
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(color: tBlack, fontSize: 10),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 300),
      //       child: IconButton(
      //         onPressed: () {
      //           Navigator.of(context).push(
      //               MaterialPageRoute(builder: (context) => const MyApp()));
      //         },
      //         icon: tBack,
      //         iconSize: 20,
      //       ),
      //     ),
      //     //image
      //     Image.asset(
      //       'assets/images/airlogo.png',
      //       height: 180,
      //       width: 410,
      //     ),
      //     //Blue gradient Container
      //     Container(
      //       height: 450,
      //       width: double.infinity,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      //         gradient: const LinearGradient(colors: [tgradbut1, tgradbut2]),
      //       ),
      //       child: Column(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(top: 10, left: 5),
      //             child: const Text(
      //               "Register",
      //               style: TextStyle(
      //                 color: tWhite,
      //                 fontSize: 20,
      //               ),
      //             ),
      //           ),
      //           //Row for First and Last Name
      //           Row(
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 20, top: 10),
      //                 child: Container(
      //                   width: 150,
      //                   child: TextFormField(
      //                     style: TextStyle(
      //                       fontSize: 10,
      //                       color: tWhite,
      //                     ),
      //                     decoration: const InputDecoration(
      //                       border: UnderlineInputBorder(),
      //                       prefixIcon: tProfile,
      //                       prefixIconColor: tWhite,
      //                       labelText: 'First Name',
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 15, top: 10),
      //                 child: Container(
      //                   width: 150,
      //                   child: TextFormField(
      //                     style: TextStyle(
      //                       fontSize: 10,
      //                       color: tWhite,
      //                     ),
      //                     decoration: const InputDecoration(
      //                       border: UnderlineInputBorder(),
      //                       labelText: 'Last Name',
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           //Column for other Information
      //           //EMAIL
      //           Column(
      //             children: [
      //               Padding(
      //                 padding:
      //                     const EdgeInsets.only(left: 20, right: 20, top: 10),
      //                 child: Container(
      //                   child: TextFormField(
      //                     style: TextStyle(
      //                       fontSize: 10,
      //                       color: tWhite,
      //                     ),
      //                     decoration: const InputDecoration(
      //                       border: UnderlineInputBorder(),
      //                       prefixIcon: tMail,
      //                       prefixIconColor: tWhite,
      //                       labelText: 'Email',
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               //PASSWORD
      //               Padding(
      //                 padding:
      //                     const EdgeInsets.only(left: 20, right: 20, top: 10),
      //                 child: Container(
      //                   child: TextFormField(
      //                     style: TextStyle(
      //                       fontSize: 10,
      //                       color: tWhite,
      //                     ),
      //                     keyboardType: TextInputType.visiblePassword,
      //                     obscureText: true,
      //                     decoration: const InputDecoration(
      //                         border: UnderlineInputBorder(),
      //                         prefixIcon: tPass,
      //                         prefixIconColor: tWhite,
      //                         labelText: 'Password',
      //                         hintStyle: TextStyle(
      //                           color: tWhite,
      //                         )),
      //                   ),
      //                 ),
      //               ),
      //               //CONFIRM PASSWORD
      //               Padding(
      //                 padding:
      //                     const EdgeInsets.only(left: 20, right: 20, top: 10),
      //                 child: Container(
      //                   child: TextFormField(
      //                     style: TextStyle(
      //                       fontSize: 10,
      //                       color: tWhite,
      //                     ),
      //                     keyboardType: TextInputType.visiblePassword,
      //                     obscureText: true,
      //                     decoration: const InputDecoration(
      //                         border: UnderlineInputBorder(),
      //                         prefixIcon: tPass2,
      //                         prefixIconColor: tWhite,
      //                         labelText: 'Confirm Password',
      //                         hintStyle: TextStyle(
      //                           color: tWhite,
      //                         )),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           //CONTINUE
      //           Padding(
      //             padding: const EdgeInsets.only(top: 20),
      //             child: Container(
      //               height: 25,
      //               width: 80,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(100),
      //                 color: tWhite,
      //               ),
      //               child: MaterialButton(
      //                 onPressed: () {
      //                   Navigator.of(context).push(MaterialPageRoute(
      //                       builder: (context) => const MyApp()));
      //                 },
      //                 child: const Text(
      //                   "Continue",
      //                   style: TextStyle(
      //                     fontSize: 10,
      //                     color: tBlack,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           //Divider
      //           Padding(
      //             padding: const EdgeInsets.only(
      //                 left: 30, right: 30, top: 10, bottom: 10),
      //             child: Row(
      //               children: [
      //                 Expanded(child: Divider()),
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 5, right: 5),
      //                   child: Text(
      //                     "or",
      //                     style: TextStyle(fontSize: 10),
      //                   ),
      //                 ),
      //                 Expanded(child: Divider()),
      //               ],
      //             ),
      //           ),
      //           //GOOGLE
      //           Container(
      //             height: 25,
      //             width: 190,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(100),
      //               color: tWhite,
      //             ),
      //             child: Row(
      //               children: [
      //                 MaterialButton(
      //                   onPressed: () {},
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     children: <Widget>[
      //                       Image.asset(
      //                         'assets/images/google.png',
      //                         height: 50,
      //                         width: 50,
      //                       ),
      //                       SizedBox(width: 5),
      //                       Text(
      //                         'Register with Google',
      //                         style: TextStyle(
      //                           color: Colors.black,
      //                           fontSize: 10,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             //ALREADY REGISTERED?
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(top: 20, left: 100),
      //             child: Row(
      //               children: [
      //                 Text(
      //                   "Already Registered?",
      //                   style: TextStyle(
      //                     fontSize: 10,
      //                     color: tBlack,
      //                   ),
      //                 ),
      //                 TextButton(
      //                     onPressed: () {
      //                       Navigator.of(context).push(MaterialPageRoute(
      //                           builder: (context) => const MyApp()));
      //                     },
      //                     child: const Text(
      //                       "Sign in",
      //                       style: TextStyle(color: tWhite, fontSize: 10),
      //                     ))
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}


//       //-----------------------------------------------------------

//       // Column(
//       //   children: [
//       //     Padding(
//       //       padding: const EdgeInsets.only(right: 300),
//       //       child: IconButton(
//       //         onPressed: () {
//       //           Navigator.of(context).push(
//       //               MaterialPageRoute(builder: (context) => const MyApp()));
//       //         },
//       //         icon: tBack,
//       //         iconSize: 20,
//       //       ),
//       //     ),
//       //     //image
//       //     Image.asset(
//       //       'assets/images/airlogo.png',
//       //       height: 180,
//       //       width: 410,
//       //     ),
//       //     //Blue gradient Container
//       //     Container(
//       //       height: 450,
//       //       width: double.infinity,
//       //       decoration: BoxDecoration(
//       //         borderRadius: BorderRadius.only(
//       //             topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//       //         gradient: const LinearGradient(colors: [tgradbut1, tgradbut2]),
//       //       ),
//       //       child: Column(
//       //         children: [
//       //           Padding(
//       //             padding: const EdgeInsets.only(top: 10, left: 5),
//       //             child: const Text(
//       //               "Register",
//       //               style: TextStyle(
//       //                 color: tWhite,
//       //                 fontSize: 20,
//       //               ),
//       //             ),
//       //           ),
//       //           //Row for First and Last Name
//       //           Row(
//       //             children: [
//       //               Padding(
//       //                 padding: const EdgeInsets.only(left: 20, top: 10),
//       //                 child: Container(
//       //                   width: 150,
//       //                   child: TextFormField(
//       //                     style: TextStyle(
//       //                       fontSize: 10,
//       //                       color: tWhite,
//       //                     ),
//       //                     decoration: const InputDecoration(
//       //                       border: UnderlineInputBorder(),
//       //                       prefixIcon: tProfile,
//       //                       prefixIconColor: tWhite,
//       //                       labelText: 'First Name',
//       //                     ),
//       //                   ),
//       //                 ),
//       //               ),
//       //               Padding(
//       //                 padding: const EdgeInsets.only(left: 15, top: 10),
//       //                 child: Container(
//       //                   width: 150,
//       //                   child: TextFormField(
//       //                     style: TextStyle(
//       //                       fontSize: 10,
//       //                       color: tWhite,
//       //                     ),
//       //                     decoration: const InputDecoration(
//       //                       border: UnderlineInputBorder(),
//       //                       labelText: 'Last Name',
//       //                     ),
//       //                   ),
//       //                 ),
//       //               ),
//       //             ],
//       //           ),
//       //           //Column for other Information
//       //           //EMAIL
//       //           Column(
//       //             children: [
//       //               Padding(
//       //                 padding:
//       //                     const EdgeInsets.only(left: 20, right: 20, top: 10),
//       //                 child: Container(
//       //                   child: TextFormField(
//       //                     style: TextStyle(
//       //                       fontSize: 10,
//       //                       color: tWhite,
//       //                     ),
//       //                     decoration: const InputDecoration(
//       //                       border: UnderlineInputBorder(),
//       //                       prefixIcon: tMail,
//       //                       prefixIconColor: tWhite,
//       //                       labelText: 'Email',
//       //                     ),
//       //                   ),
//       //                 ),
//       //               ),
//       //               //PASSWORD
//       //               Padding(
//       //                 padding:
//       //                     const EdgeInsets.only(left: 20, right: 20, top: 10),
//       //                 child: Container(
//       //                   child: TextFormField(
//       //                     style: TextStyle(
//       //                       fontSize: 10,
//       //                       color: tWhite,
//       //                     ),
//       //                     keyboardType: TextInputType.visiblePassword,
//       //                     obscureText: true,
//       //                     decoration: const InputDecoration(
//       //                         border: UnderlineInputBorder(),
//       //                         prefixIcon: tPass,
//       //                         prefixIconColor: tWhite,
//       //                         labelText: 'Password',
//       //                         hintStyle: TextStyle(
//       //                           color: tWhite,
//       //                         )),
//       //                   ),
//       //                 ),
//       //               ),
//       //               //CONFIRM PASSWORD
//       //               Padding(
//       //                 padding:
//       //                     const EdgeInsets.only(left: 20, right: 20, top: 10),
//       //                 child: Container(
//       //                   child: TextFormField(
//       //                     style: TextStyle(
//       //                       fontSize: 10,
//       //                       color: tWhite,
//       //                     ),
//       //                     keyboardType: TextInputType.visiblePassword,
//       //                     obscureText: true,
//       //                     decoration: const InputDecoration(
//       //                         border: UnderlineInputBorder(),
//       //                         prefixIcon: tPass2,
//       //                         prefixIconColor: tWhite,
//       //                         labelText: 'Confirm Password',
//       //                         hintStyle: TextStyle(
//       //                           color: tWhite,
//       //                         )),
//       //                   ),
//       //                 ),
//       //               ),
//       //             ],
//       //           ),
//       //           //CONTINUE
//       //           Padding(
//       //             padding: const EdgeInsets.only(top: 20),
//       //             child: Container(
//       //               height: 25,
//       //               width: 80,
//       //               decoration: BoxDecoration(
//       //                 borderRadius: BorderRadius.circular(100),
//       //                 color: tWhite,
//       //               ),
//       //               child: MaterialButton(
//       //                 onPressed: () {
//       //                   Navigator.of(context).push(MaterialPageRoute(
//       //                       builder: (context) => const MyApp()));
//       //                 },
//       //                 child: const Text(
//       //                   "Continue",
//       //                   style: TextStyle(
//       //                     fontSize: 10,
//       //                     color: tBlack,
//       //                   ),
//       //                 ),
//       //               ),
//       //             ),
//       //           ),
//       //           //Divider
//       //           Padding(
//       //             padding: const EdgeInsets.only(
//       //                 left: 30, right: 30, top: 10, bottom: 10),
//       //             child: Row(
//       //               children: [
//       //                 Expanded(child: Divider()),
//       //                 Padding(
//       //                   padding: const EdgeInsets.only(left: 5, right: 5),
//       //                   child: Text(
//       //                     "or",
//       //                     style: TextStyle(fontSize: 10),
//       //                   ),
//       //                 ),
//       //                 Expanded(child: Divider()),
//       //               ],
//       //             ),
//       //           ),
//       //           //GOOGLE
//       //           Container(
//       //             height: 25,
//       //             width: 190,
//       //             decoration: BoxDecoration(
//       //               borderRadius: BorderRadius.circular(100),
//       //               color: tWhite,
//       //             ),
//       //             child: Row(
//       //               children: [
//       //                 MaterialButton(
//       //                   onPressed: () {},
//       //                   child: Row(
//       //                     mainAxisAlignment: MainAxisAlignment.start,
//       //                     children: <Widget>[
//       //                       Image.asset(
//       //                         'assets/images/google.png',
//       //                         height: 50,
//       //                         width: 50,
//       //                       ),
//       //                       SizedBox(width: 5),
//       //                       Text(
//       //                         'Register with Google',
//       //                         style: TextStyle(
//       //                           color: Colors.black,
//       //                           fontSize: 10,
//       //                         ),
//       //                       ),
//       //                     ],
//       //                   ),
//       //                 ),
//       //               ],
//       //             ),
//       //             //ALREADY REGISTERED?
//       //           ),
//       //           Padding(
//       //             padding: const EdgeInsets.only(top: 20, left: 100),
//       //             child: Row(
//       //               children: [
//       //                 Text(
//       //                   "Already Registered?",
//       //                   style: TextStyle(
//       //                     fontSize: 10,
//       //                     color: tBlack,
//       //                   ),
//       //                 ),
//       //                 TextButton(
//       //                     onPressed: () {
//       //                       Navigator.of(context).push(MaterialPageRoute(
//       //                           builder: (context) => const MyApp()));
//       //                     },
//       //                     child: const Text(
//       //                       "Sign in",
//       //                       style: TextStyle(color: tWhite, fontSize: 10),
//       //                     ))
//       //               ],
//       //             ),
//       //           ),
//       //         ],
//       //       ),
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }

