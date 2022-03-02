import 'package:flutter/material.dart';
import 'package:fx_nno_es_plus/pages/init.dart';
import 'package:flutter/services.dart';

void main() => runApp(const Calculator());

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(
    //       statusBarColor: Colors.blueGrey,
    //       systemNavigationBarColor: Colors.transparent
    //     )
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FX 991es plus',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: SimpleCalculator(),
    );
  }
}
