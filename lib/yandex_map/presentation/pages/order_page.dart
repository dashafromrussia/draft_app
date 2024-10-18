import 'package:flutter/material.dart';


class OrderPage extends StatefulWidget {
  final String text;
  const OrderPage({super.key,required this.text});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Ваш адрес: \n${widget.text}"),
      ),
    );
  }
}


