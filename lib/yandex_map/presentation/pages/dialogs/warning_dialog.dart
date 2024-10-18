import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_bloc.dart';
import 'package:untitled/yandex_map/presentation/bloc/data_bloc.dart';
import 'package:untitled/yandex_map/presentation/pages/order_page.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';
import 'package:flutter/material.dart';

import '../../../../users/presentation/bloc/individ/individ_event.dart';

class WarningDialog extends StatelessWidget {
  final String text;
  final BuildContext contextF;
  const WarningDialog({
    super.key, required this.text,required this.contextF
  });

  static Future<bool?> showDialog(BuildContext context, {
    required String title,
    required String text,
  }) async
  {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'warning',
      //useRootNavigator: true,
      pageBuilder: (contextB, animation, secondAnimation) =>
          WarningDialog(
            contextF: context,
            text: text,
            // keyboard related
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(8),
          color: Theme.of(context).backgroundColor,
        ),
        constraints: BoxConstraints.loose(
            Size(344, double.infinity)
        ),
        padding: EdgeInsets.all(16),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child:
          SingleChildScrollView(
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed:(){
                          Navigator.of(context).pop();
                        },
                        icon:const Icon(
                          Icons.close_rounded,
                          size: 30,
                        ),
                        alignment: Alignment.topRight,
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Данные: $text",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                ]),
          ),

        ),
      ),
    );
  }
}


class WarningMyPosDialog extends StatefulWidget {
  final String text;
  final BuildContext contextF;
  const WarningMyPosDialog({
    super.key, required this.text,required this.contextF
  });
  static Future<bool?> showDialog(BuildContext context, {
    required String title,
    required String text,
  }) async
  {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'warning',
      //useRootNavigator: true,
      pageBuilder: (contextB, animation, secondAnimation) =>
          WarningMyPosDialog(
            contextF: context,
            text: text,
            // keyboard related
          ),
    );
  }

  @override
  State<WarningMyPosDialog> createState() => _WarningMyPosDialogState();
}

class _WarningMyPosDialogState extends State<WarningMyPosDialog> {



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(8),
          color: Theme.of(context).backgroundColor,
        ),
        constraints: BoxConstraints.loose(
            Size(344, double.infinity)
        ),
        padding: EdgeInsets.all(16),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child:
          SingleChildScrollView(
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed:(){
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          size: 30,
                        ),
                        alignment: Alignment.topRight,
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Ваш адрес: ${widget.text}",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(onPressed:(){
                       /* GetIt.I.get<IndividBloc>()
                            .add(UpdateIndividAddressEvent(address:widget.text));
                        widget.contextF.read<DataBloc>().add(ChangeDataEvent(text:
                        widget.text));*/
                        widget.contextF.read<IndividBloc>()
                            .add(UpdateIndividAddressEvent(address:widget.text));
                        Navigator.of(context).pop();
                        widget.contextF.push('/individ/maps/order',extra: {'text':widget.text});
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  OrderPage(text: widget.text)),
                        );*/
                      }, child:const Text("да")),
                      ElevatedButton(onPressed:(){
                        Navigator.of(context).pop();
                      }, child:const Text("нет")),
                    ],
                  )
                ]),
          ),

        ),
      ),
    );
  }
}
