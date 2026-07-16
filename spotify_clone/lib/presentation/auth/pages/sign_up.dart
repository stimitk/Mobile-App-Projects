import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:spotify_clone/common/widgets/buttons/basic_app_button.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/data/models/auth/create_user_request.dart';
import 'package:spotify_clone/domain/usecases/auth/sign_up_use_case.dart';
import 'package:spotify_clone/presentation/auth/pages/sign_in.dart';
import 'package:spotify_clone/presentation/root/pages/root.dart';
import 'package:spotify_clone/service_locator.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.spotifyLogo, height: 32, width: 32),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 64),
              _fullNameField(context),
              const SizedBox(height: 24),
              _emailField(context),
              const SizedBox(height: 24),
              _passwordField(context),
              const SizedBox(height: 48),
              BasicAppButton(
                onPressed: () async {
                  var result = await sl<SignUpUseCase>().call(
                    params: CreateUserRequest(
                      fullName: _fullName.text.toString(),
                      email: _email.text.toString(),
                      password: _password.text.toString(),
                    ),
                  );
                  return result.fold(
                    (left) {
                      var snackBar = SnackBar(content: Text(left));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    (right) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Root(),
                        ),
                        (root) => false,
                      );
                    },
                  );
                },
                title: 'Create Account',
              ),
              const SizedBox(height: 200),
              _signInText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return Text(
      'Register',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: InputDecoration(
        hintText: 'Full Name',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
        hintText: 'Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Do you have an account?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SignIn()),
              );
            },
            child: Text(
              'Sign In',
              style: TextStyle(color: Colors.blue, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
