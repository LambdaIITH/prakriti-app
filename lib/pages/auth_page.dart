import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  bool newUser = false;

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
                        onPressed: () {},
                        child: const Text("Login"),
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
