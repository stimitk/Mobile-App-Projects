import 'package:dartz/dartz.dart';
import 'package:spotify_clone/data/models/auth/create_user_request.dart';
import 'package:spotify_clone/data/models/auth/sign_in_user_request.dart';
import 'package:spotify_clone/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signIn(SignInUserRequest signInUserRequest) async {
    return await sl<AuthFirebaseService>().signin(signInUserRequest);
  }

  @override
  Future<Either> signUp(CreateUserRequest cerateUserRequest) async {
    return await sl<AuthFirebaseService>().signup(cerateUserRequest);
  }
}
