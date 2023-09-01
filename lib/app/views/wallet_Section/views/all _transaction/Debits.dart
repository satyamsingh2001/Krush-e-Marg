import 'package:flutter/material.dart';
class DebitsTransaction extends StatefulWidget {
  const DebitsTransaction({Key? key}) : super(key: key);

  @override
  State<DebitsTransaction> createState() => _DebitsTransactionState();
}

class _DebitsTransactionState extends State<DebitsTransaction> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/icons/notransaction.png'),
    );
  }
}
