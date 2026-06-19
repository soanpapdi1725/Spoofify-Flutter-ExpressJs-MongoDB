import 'dart:convert';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/app_failure/app_failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_remote_repository.g.dart';

// Creating the authRemoteRepository function which return authremoterepository
@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> getCurrentUserData(String token) async {
    try {
      final response = await http.post(
        Uri.parse("${ServerConstant.authServerApi}/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      final resFromBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(AppFailure(resFromBody["message"]));
      }
      return Right(
        UserModel.fromMap(resFromBody['data']).copyWith(token: token),
      );
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> signUpFunction({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ServerConstant.authServerApi}/signup"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      final resFromBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(AppFailure(resFromBody["message"]));
      }
      final dataFromResponse = resFromBody['data'];
      return Right(UserModel.fromMap(dataFromResponse));
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> loginFunction({
    required String email,
    required String password,
  }) async {
    try {

      final response = await http.post(
        Uri.parse("${ServerConstant.authServerApi}/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final user = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(AppFailure(user["message"]));
      }
      return Right(UserModel.fromMap(user['data']));
    } catch (error) {
      return Left(AppFailure(error.toString()));
    }
  }
}
