import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';
part 'data.g.dart';

@freezed
class LoginData with _$LoginData {
  const factory LoginData({required String f_session,
  required int f_user_id}) = _LoginData;
  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);
}