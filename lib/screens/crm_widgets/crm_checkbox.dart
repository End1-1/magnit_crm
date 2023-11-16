import 'package:flutter/material.dart';

class CrmCheckbox extends StatefulWidget {
  bool checked;
  final Function(bool) check;

  CrmCheckbox(this.checked, this.check, {super.key});

  @override
  State<StatefulWidget> createState() => _CrmCheckbox();
}

class _CrmCheckbox extends State<CrmCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: widget.checked,
        onChanged: (v) {
          widget.checked = v ?? false;
          widget.check(widget.checked);
          setState(() {});
        });
  }
}
