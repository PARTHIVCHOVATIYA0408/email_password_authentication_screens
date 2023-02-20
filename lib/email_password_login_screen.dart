import 'package:email_password_authentication_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'email_password_signin_screen.dart';

class EmailPasswordLoginScreen extends StatefulWidget {
  const EmailPasswordLoginScreen({super.key});

  @override
  State<EmailPasswordLoginScreen> createState() =>
      _EmailPasswordLoginScreenState();
}

class _EmailPasswordLoginScreenState extends State<EmailPasswordLoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Password Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter Email',
                icon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                icon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                userLogIn();
              },
              child: Container(
                height: 45,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EemailPasswordSignInScreen(),
                  ),
                );
              },
              child: Container(
                height: 45,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'CREATE A NEW ACCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  userLogIn() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (auth.currentUser!.emailVerified) {
        debugPrint("currentUser ----------->>> ${auth.currentUser}");
        navigator();
      } else {
        debugPrint("Please verify your email");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("e.code ----------->>> ${e.code}");
      if (e.code == 'invalid-email') {
        debugPrint('The invalid email provided.');
      } else if (e.code == 'user-not-found') {
        debugPrint('Email is not exist in the app');
      } else if (e.code == 'wrong-password') {
        debugPrint('The password provided is Wrong');
      } else if (e.code == 'unknown') {
        debugPrint('Please put data in field');
      }
    } catch (e) {
      debugPrint("Error ----->> $e");
    }
  }

  navigator() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScren(),
      ),
      (route) => false,
    );
  }
}
