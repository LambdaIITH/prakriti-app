import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prakriti_app/providers/auth_provider.dart';

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
        .then(
          (value) =>
              FirebaseFirestore.instance.collection("users").doc(email).set(
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
        .then(
      (value) async {
        FirebaseFirestore.instance.collection("users").doc(email).get().then(
              (value) => isAdmin = value.data()?.values.toString() == 'admin',
            );
        // print(role);
      },
    );
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
                  TextFormField(
                    decoration: const InputDecoration(
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
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
                  if (newUser)
                    TextFormField(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
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
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            newUser = !newUser;
                          });
                        },
                        child: (!newUser)
                            ? const Text("New user")
                            : const Text("back"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
