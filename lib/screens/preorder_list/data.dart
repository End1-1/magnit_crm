import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';

part 'data.g.dart';

@freezed
class Preorder with _$Preorder {
  const factory Preorder({
    required String f_id,
    required int f_table,
    required String f_tablename,
    required String f_datefor,
    required String f_timefor,
    required int f_guests,
    required String f_comment,
    required String f_feedback,
    required int f_guest,
    required String f_guestname,
    required String f_guesttaxname,
    required String f_guestphone,
    required String f_guestemail,
    required double f_prepaidcash,
    required double f_prepaidcard,
    required int f_state,
    required String f_statename,
  }) = _Preorder;

  factory Preorder.fromJson(Map<String, dynamic> json) =>
      _$PreorderFromJson(json);
}
