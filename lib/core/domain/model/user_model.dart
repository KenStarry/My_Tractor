import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
      {String? uid,
      String? fullName,
      String? email,
      String? phoneNumber,
      String? userType,
      double? latitude,
      double? longitude,
      List<String>? acceptedRequests,
      List<String>? requests}) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
