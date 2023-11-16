import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/crm_app/model.dart';
import 'package:magnit_crm/screens/preorder_list/data.dart';
import 'package:magnit_crm/screens/select_dialog/model.dart';
import 'package:magnit_crm/screens/select_dialog/screen.dart';
import 'package:magnit_crm/utils/keys.dart';
import 'package:intl/intl.dart';
import 'package:magnit_crm/utils/prefs.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PreorderScreenModel extends CrmModel {
  final tableController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneMaskFormatter = MaskTextInputFormatter(mask: "+374 (##) ##-##-##", type: MaskAutoCompletionType.eager);
  final guestController = TextEditingController();
  final guestCountController = TextEditingController();
  final amountController = TextEditingController();
  final emailController = TextEditingController();
  final commentController = TextEditingController();
  final feedbackController = TextEditingController();
  var tableId = 0;
  Preorder? preorder;

  PreorderScreenModel({this.preorder}) {
    if (preorder != null) {
      tableId = preorder!.f_table;
      tableController.text = preorder!.f_tablename;
      dateController.text = prefs.dateString(preorder!.f_datefor);
      timeController.text = preorder!.f_timefor;
      phoneController.text = phoneMaskFormatter.unmaskText(preorder!.f_guestphone);
      guestController.text = preorder!.f_guestname;
      guestCountController.text = '${preorder!.f_guests}';
      amountController.text = '${preorder!.f_prepaidcash}';
      emailController.text = preorder!.f_guestemail;
      commentController.text = preorder!.f_comment;
      feedbackController.text = preorder!.f_feedback;
    }
  }

  void selectTable() {
    navigate(SelectDialogScreen(
            model: SelectDialogModel('free_preorder_table'),
            title: tr('Select table')))
        .then((value) {
          if (value != null) {
            tableId = value['f_id']!;
            tableController.text = value['f_name']!;
          }
    });
  }

  void selectDate() {
    showDatePicker(
            context: navigatorKey.currentContext!,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 90)))
        .then((value) {
      if (value != null) {
        dateController.text = DateFormat('dd/MM/yyyy').format(value);
      }
    });
  }

  void selectTime() {
    showTimePicker(
            context: navigatorKey.currentContext!, initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        timeController.text = '${value.hour}:${value.minute}:00';
      }
    });
  }

  void okCreated(dynamic d) {
      dialogOk = (){
        Navigator.pop(navigatorKey.currentContext!, true);
      };
      dialogController.add(tr('Preorder created'));
  }

  void save() {
    String err = '';
    if (tableId == 0) {
      err += '${tr('Select table')}\r\n';
    }
    if (dateController.text.isEmpty) {
      err += '${tr('Select data')}\r\n';
    }
    if (timeController.text.isEmpty) {
      err += '${tr('Select time')}\r\n';
    }
    if (phoneController.text.isEmpty) {
      err += '${tr('Enter the phone number')}\r\n';
    }
    if (phoneMaskFormatter.getMaskedText().length < 12) {
      err += '${tr('Phone number format is invalid')}\r\n';
    }
    if (guestController.text.isEmpty) {
      err += '${tr('Enter the guest name')}\r\n';
    }
    if ((int.tryParse(guestCountController.text) ?? 0) == 0) {
      err += '${tr('Enter the count of guests')}\r\n';
    }
    if (commentController.text.isEmpty) {
      err += '${tr('Make sure, there are no comments')}\r\n';
    }
    if (err.isNotEmpty) {
      dialogController.add(err);
      return;
    }
    Map<String, dynamic> params = {
      'call': 'sp_create_preorder',
      'format': 1,
          'params':{
            'f_id': preorder?.f_id,
            'f_table': tableId,
            'f_staff': prefs.getInt(pkUserId),
            'date': DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(dateController.text)),
            'time': timeController.text,
            'phone': phoneController.text,
            'guest': guestController.text,
            'email': emailController.text,
            'guests_count': int.tryParse(guestCountController.text) ?? 0,
            'prepaid': double.tryParse(amountController.text) ?? 0,
            'comments': commentController.text,
            'feedback': feedbackController.text,
          }
    };
    super.httpQuery(params, okFunction: okCreated);
  }
}
