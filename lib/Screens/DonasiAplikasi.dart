import 'package:flutter/material.dart';

class DonasiAplikasi extends StatefulWidget {
  const DonasiAplikasi({Key? key}) : super(key: key);

  @override
  State<DonasiAplikasi> createState() => _DonasiAplikasiState();
}

class _DonasiAplikasiState extends State<DonasiAplikasi> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Donasi Aplikasi'),
      ),
    );
  }
}
