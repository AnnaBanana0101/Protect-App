import 'package:flutter/material.dart';

class CalmPage extends StatefulWidget {
  const CalmPage({super.key});

  @override
  State<CalmPage> createState() => _CalmPageState();
}

class _CalmPageState extends State<CalmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Calm'),
      )
    );
  }
}