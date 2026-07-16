import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecases/use_case.dart';
import 'package:spotify_clone/data/models/auth/create_user_request.dart';
import 'package:spotify_clone/domain/repository/auth/auth_repository.dart';
import 'package:spotify_clone/service_locator.dart';

class SignUpUseCase implements UseCase<Either, CreateUserRequest> {
  @override
  Future<Either<dynamic, dynamic>> call({CreateUserRequest? params}) {
    return sl<AuthRepository>().signUp(params!);
  }
}
