import 'package:flutter/material.dart';
import 'appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarBottomNavigator(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Beranda'),
        ),
        body: Center(
          child: Text(
            'Halo',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
