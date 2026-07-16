import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:spotify_clone/common/widgets/buttons/basic_app_button.dart';
import 'package:spotify_clone/core/configs/app_colors.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/presentation/auth/pages/sign_in.dart';
import 'package:spotify_clone/presentation/auth/pages/sign_up.dart';

class SignupOrSignin extends StatelessWidget {
  const SignupOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBg),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.spotifyLogo),
                  const SizedBox(height: 60),
                  const Text(
                    'Enjoy listening to music',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 52),

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignUp()),
                            );
                          },
                          title: 'Register',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignIn()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 0,
                            ),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: context.isDarkMode
                                    ? AppColors.lightBackground
                                    : AppColors.darkGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
