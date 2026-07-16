import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecases/use_case.dart';
import 'package:spotify_clone/data/models/auth/sign_in_user_request.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';
import 'package:spotify_clone/service_locator.dart';

class SignInUseCase implements UseCase<Either, SignInUserRequest> {
  @override
  Future<Either<dynamic, dynamic>> call({SignInUserRequest? params}) {
    return sl<AuthRepository>().signIn(params!);
  }
}
