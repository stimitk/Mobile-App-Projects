import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/data/models/auth/create_user_request.dart';
import 'package:spotify_clone/data/models/auth/sign_in_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserRequest createUserRequest);
  Future<Either>  signin(SignInUserRequest signInUserRequest);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SignInUserRequest signInUserRequest) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserRequest.email,
        password: signInUserRequest.password,
      );

      return Right('Sign in was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found. Verify email again.';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid username or password';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserRequest createUserRequest) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserRequest.email,
        password: createUserRequest.password,
      );

      return Right('Sign up was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with this email';
      }
      return Left(message);
    }
  }
}
