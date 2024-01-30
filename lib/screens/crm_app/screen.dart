import 'package:flutter/material.dart';
import 'package:magnit_crm/screens/crm_app/model.dart';
import 'package:magnit_crm/screens/crm_widgets/cmr_text_button.dart';
import 'package:magnit_crm/screens/crm_widgets/crm_text.dart';

class CrmApp extends StatelessWidget {
  late final CrmModel _model;

  CrmApp({super.key, required CrmModel m}) {
    _model = m;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: appBar(context) ?? Container(),
                    )
                  ],
                ),
                const Divider(),

                for (final w in body(context))
                  w,
              ]),

                //Loading indicator
                StreamBuilder(
                    stream: _model.loadingIndicatorController.stream,
                    builder: (builder, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          color: Colors.black12,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Container();
                    }),

                //Dialog widget
                StreamBuilder<String?>(
                    stream: _model.dialogController.stream,
                    builder: (builder, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            color: Colors.black12,
                            child: Center(
                                child: Container(
                                    height: MediaQuery
                                        .sizeOf(context)
                                        .height * 0.7,
                                    width: MediaQuery
                                        .sizeOf(context)
                                        .width * 0.7,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [crmText(snapshot.data!)],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(child: Container()),
                                            crmTextButton(_model.tr('Close'),
                                                _model.dialogOkPressed),
                                            Expanded(child: Container()),
                                          ],
                                        )
                                      ],
                                    ))));
                      }
                      return Container();
                    })
              ])),
    );
  }

  List<Widget> body(BuildContext context) {
    return [];
  }

  PreferredSize? appBar(BuildContext context) {
    return null;
  }
}
