import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magnit_crm/screens/crm_app/model.dart';
import 'package:magnit_crm/screens/crm_widgets/cmr_text_button.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text.dart';
import 'package:magnit_crm/screens/preorder_list/data.dart';
import 'package:magnit_crm/screens/select_dialog/model.dart';
import 'package:magnit_crm/screens/select_dialog/screen.dart';
import 'package:magnit_crm/utils/keys.dart';
import 'package:magnit_crm/utils/prefs.dart';

class PreorderScreenModel extends CrmModel {
  final tableController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final phoneController = TextEditingController();

  //final phoneMaskFormatter = MaskTextInputFormatter(mask: "+374 (##) ##-##-##", type: MaskAutoCompletionType.eager);
  final guestController = TextEditingController();
  final guestCountController = TextEditingController();
  final amountCashController = TextEditingController();
  final amountCardController = TextEditingController();
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
      phoneController.text = preorder!.f_guestphone;
      guestController.text = preorder!.f_guestname;
      guestCountController.text = '${preorder!.f_guests}';
      amountCashController.text = '${preorder!.f_prepaidcash}';
      amountCardController.text = '${preorder!.f_prepaidcard}';
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
            firstDate: DateTime.now().add(const Duration(days: -270)),
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

  Future<void> findInfo() async {
    httpQuery({
      'call': 'sf_find_info',
      'format': 3,
      'params': {'phone': phoneController.text}
    }, okFunction: okFindInfo);
  }

  void okCreated(dynamic d) {
    dialogOk = () {
      Navigator.pop(navigatorKey.currentContext!, true);
    };
    dialogController.add(tr('Preorder created'));
  }

  void okFindInfo(d) {
    guestController.text = d['f_name'];
    emailController.text = d['f_email'];
  }

  void okRemoved(d) {
    Navigator.pop(navigatorKey.currentContext!, true);
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
    // if (phoneMaskFormatter.masked.length < 12) {
    //   err += '${tr('Phone number format is invalid')}\r\n';
    // }
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
      'params': {
        'f_id': preorder?.f_id,
        'f_table': tableId,
        'f_staff': prefs.getInt(pkUserId),
        'state_id': 5,
        'date': DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd/MM/yyyy').parse(dateController.text)),
        'time': timeController.text,
        'phone': phoneController.text,
        'guest': guestController.text,
        'email': emailController.text,
        'guests_count': int.tryParse(guestCountController.text) ?? 0,
        'prepaid': double.tryParse(amountCashController.text) ?? 0,
        'prepaidcard': double.tryParse(amountCardController.text) ?? 0,
        'comments': commentController.text,
        'feedback': feedbackController.text,
      }
    };
    super.httpQuery(params, okFunction: okCreated);
  }

  Future<void> delete() async {
    if (preorder == null || preorder!.f_id.isEmpty) {
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (builder) {
            return AlertDialog(content: crmText(tr('Preorder was not saved')));
          });
      return;
    }
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (builder) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(30),
            children: [
              crmText(tr('Confirm to remove')),
              Row(children: [
                crmTextButton(tr('Remove'), () {
                  Navigator.pop(builder, true);
                }),
                crmTextButton(tr('Cancel'), () {
                  Navigator.pop(builder);
                })
              ])
            ],
          );
        }).then((value) {
      if (value ?? false) {
        super.httpQuery({
          'call': 'sf_remove_preorder',
          'format': 3,
          'params': {'id': preorder?.f_id}
        }, okFunction: okRemoved);
      }
    });
  }
}
