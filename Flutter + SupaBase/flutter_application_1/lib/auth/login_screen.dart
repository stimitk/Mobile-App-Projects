import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/register_screen.dart';
import 'package:flutter_application_1/home/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool loading = false;
  final supabase = Supabase.instance.client;

  login() async {
    setState(() {
      loading = true;
    });

    try {
      final result = await supabase.auth.signInWithPassword(
        email: _email.text,
        password: _password.text,
      );

      if (result.user != null && result.session != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (context) => false,
        );
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  continueWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId: dotenv.env['WEB_CLIENT']!,
        clientId: Platform.isAndroid
            ? dotenv.env['ANDROID_CLIENT']!
            : dotenv.env['IOS_CLIENT']!,
      );
      GoogleSignInAccount googleSignInAccount = await googleSignIn
          .authenticate();

      String idToken = googleSignInAccount.authentication.idToken ?? '';
      final authorization =
          await googleSignInAccount.authorizationClient.authorizationForScopes([
            'email',
            'profile',
          ]) ??
          await googleSignInAccount.authorizationClient.authorizeScopes([
            'email',
            'profile',
          ]);

      final result = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );

      if (result.user != null && result.session != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (context) => false,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _email,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _password,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          SizedBox(height: 16),

          loading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text('Login'),
                ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              continueWithGoogle();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/google.png', height: 30),
                SizedBox(width: 16),
                Text('Signin with Google'),
              ],
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
            child: Text('Don\'t have an account? Register here'),
          ),
        ],
      ),
    );
  }
}
