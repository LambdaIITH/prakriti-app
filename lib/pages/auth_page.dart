import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late AuthProvider auth;

  Future<void> signUp({
    required String email,
    required String passwd,
  }) async {
    try {
      await AuthProvider()
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
    } on FirebaseAuthException catch (error) {
      int index = error.toString().indexOf(' ');
      final snackBar = SnackBar(
        content: Text(
          error.toString().substring(index),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> logIn({
    required String email,
    required String passwd,
  }) async {
    try {
      await AuthProvider().signInWithEmailAndPassword(
        email: email,
        passwd: passwd,
      );
    } on FirebaseAuthException catch (error) {
      int index = error.toString().indexOf(' ');
      // print(er);
      final snackBar = SnackBar(
        content: Text(
          error.toString().substring(index),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                    style: GoogleFonts.alexBrush(
                      fontSize: 64,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Neumorphic(
                    padding: const EdgeInsets.all(4),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(24),
                      ),
                      depth: 2.5,
                      intensity: 1,
                      lightSource: LightSource.topLeft,
                      color: Colors.grey[200],
                    ),
                    child: TextFormField(
                      cursorColor: Colors.grey[600],
                      cursorHeight: 30,
                      style: regularTextFontStyle,
                      decoration: InputDecoration(
                        errorBorder: InputBorder.none,
                        errorStyle: errorFontStyle,
                        contentPadding: const EdgeInsets.all(8),
                        hintStyle: hintFontStyle,
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
                    padding: const EdgeInsets.all(4),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(24),
                      ),
                      depth: 2.5,
                      intensity: 1,
                      lightSource: LightSource.topLeft,
                      color: Colors.grey[200],
                    ),
                    child: TextFormField(
                      cursorColor: Colors.grey[600],
                      cursorHeight: 30,
                      obscureText: true,
                      decoration: InputDecoration(
                        errorBorder: InputBorder.none,
                        errorStyle: errorFontStyle,
                        contentPadding: const EdgeInsets.all(8),
                        hintStyle: hintFontStyle,
                        border: InputBorder.none,
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
                  const SizedBox(
                    height: 20,
                  ),
                  if (newUser)
                    Neumorphic(
                      padding: const EdgeInsets.all(4),
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(24),
                        ),
                        depth: 2.5,
                        intensity: 1,
                        lightSource: LightSource.topLeft,
                        color: Colors.grey[200],
                      ),
                      child: TextFormField(
                        cursorColor: Colors.grey[600],
                        cursorHeight: 30,
                        obscureText: true,
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          errorStyle: errorFontStyle,
                          contentPadding: const EdgeInsets.all(8),
                          hintStyle: hintFontStyle,
                          border: InputBorder.none,
                          hintText: "confirm password",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter e-mail here";
                          }
                          return null;
                        },
                      ),
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
