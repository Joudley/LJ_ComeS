import 'package:flutter/material.dart';
import './BoutonPeye.dart';
import './AfficheLisPwodwi.dart';
import 'model/Product.dart';

class AficherLisPwodwiAkAppBar extends StatelessWidget{

  final Future<List<Product>> Function() rekiperePwodwi;

  AficherLisPwodwiAkAppBar({super.key, required this.rekiperePwodwi, });

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Lis Pwodwi",style: style,),
        actions: [
          BoutonPeye(),
        ],
      ),
      body: LisPwodwi(rekiperePwodwi: rekiperePwodwi),
    );
  }

}