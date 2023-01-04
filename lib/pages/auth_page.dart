import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:prakriti_app/providers/auth_provider.dart';
import 'package:prakriti_app/theme_data.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String email = "";
  String passwd = "";
  final _formKey = GlobalKey<FormState>();
  bool newUser = false;
  bool isAdmin = false;

  Future<void> signUp({
    required String email,
    required String passwd,
  }) async {
    AuthProvider()
        .createUserWithEmailAndPassword(
      email: email,
      passwd: passwd,
    )
        .onError((error, stackTrace) {
      final snackBar = SnackBar(
        content: Text(
          error.toString(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).then(
      (value) => FirebaseFirestore.instance.collection("users").doc(email).set(
        {
          "role": "user",
        },
      ),
    );
  }

  Future<void> logIn({
    required String email,
    required String passwd,
  }) async {
    AuthProvider()
        .signInWithEmailAndPassword(
      email: email,
      passwd: passwd,
    )
        .onError((error, stackTrace) {
      final snackBar = SnackBar(
        content: Text(
          error.toString(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    "Prakriti",
                    style: titleFontStyle,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(24),
                      ),
                      depth: 5,
                      intensity: 1,
                      lightSource: LightSource.topLeft,
                      color: Colors.grey[200],
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black87,
                      style: regularTextFontStyle,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        hintStyle: regularTextFontStyle,
                        border: InputBorder.none,
                        hintText: "e-mail",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter e-mail here";
                        }
                        return null;
                      },
                      onSaved: (newValue) => email = newValue!,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(24),
                      ),
                      depth: 5,
                      intensity: 1,
                      lightSource: LightSource.topLeft,
                      color: Colors.grey[200],
                    ),
                    child: TextFormField(
                      obscureText: true,
                      cursorColor: Colors.black87,
                      decoration: const InputDecoration(
                        hintText: "password",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter e-mail here";
                        }
                        return null;
                      },
                      onSaved: (newValue) => passwd = newValue!,
                    ),
                  ),
                  if (newUser)
                    TextFormField(
                      obscureText: true,
                      cursorColor: Colors.black87,
                      decoration: const InputDecoration(
                        hintText: "confirm password",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter e-mail here";
                        }
                        return null;
                      },
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (newUser) {
                          signUp(
                            email: email,
                            passwd: passwd,
                          );
                        } else {
                          logIn(
                            email: email,
                            passwd: passwd,
                          );
                        }
                      }
                    },
                    child: Text((!newUser) ? "Login" : "SignUp"),
                  ),
                  const Spacer(),
                  NeumorphicButton(
                    onPressed: () {
                      setState(() {
                        newUser = !newUser;
                      });
                    },
                    child: (!newUser)
                        ? Text(
                            "new to the community",
                            style: regularTextFontStyle,
                          )
                        : Text(
                            "back to login",
                            style: regularTextFontStyle,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
