// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreorderImpl _$$PreorderImplFromJson(Map<String, dynamic> json) =>
    _$PreorderImpl(
      f_id: json['f_id'] as String,
      f_table: json['f_table'] as int,
      f_tablename: json['f_tablename'] as String,
      f_datefor: json['f_datefor'] as String,
      f_timefor: json['f_timefor'] as String,
      f_guests: json['f_guests'] as int,
      f_comment: json['f_comment'] as String,
      f_feedback: json['f_feedback'] as String,
      f_guest: json['f_guest'] as int,
      f_guestname: json['f_guestname'] as String,
      f_guesttaxname: json['f_guesttaxname'] as String,
      f_guestphone: json['f_guestphone'] as String,
      f_guestemail: json['f_guestemail'] as String,
      f_prepaidcash: (json['f_prepaidcash'] as num).toDouble(),
      f_prepaidcard: (json['f_prepaidcard'] as num).toDouble(),
      f_state: json['f_state'] as int,
      f_statename: json['f_statename'] as String,
    );

Map<String, dynamic> _$$PreorderImplToJson(_$PreorderImpl instance) =>
    <String, dynamic>{
      'f_id': instance.f_id,
      'f_table': instance.f_table,
      'f_tablename': instance.f_tablename,
      'f_datefor': instance.f_datefor,
      'f_timefor': instance.f_timefor,
      'f_guests': instance.f_guests,
      'f_comment': instance.f_comment,
      'f_feedback': instance.f_feedback,
      'f_guest': instance.f_guest,
      'f_guestname': instance.f_guestname,
      'f_guesttaxname': instance.f_guesttaxname,
      'f_guestphone': instance.f_guestphone,
      'f_guestemail': instance.f_guestemail,
      'f_prepaidcash': instance.f_prepaidcash,
      'f_prepaidcard': instance.f_prepaidcard,
      'f_state': instance.f_state,
      'f_statename': instance.f_statename,
    };
