import 'package:flutter/material.dart';
import './BoutonPeye.dart';
import 'FavoriPanyeBtn.dart';
import 'model/Product.dart';

//afiche detay sou yon pwodwi
class DetayPwodwi extends StatelessWidget {
  final Product product;
  final int userId;

  const DetayPwodwi({Key? key, required this.product, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    const double sizeBoxHeight = 10;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detay Pwodwi',
          style: style,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          BoutonPeye(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sizeBoxHeight),
              Image.network(
                product.image!,
                height: 300,
                width: double.infinity,
              ),
              SizedBox(height: sizeBoxHeight),
              Text(
                product.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: sizeBoxHeight),
              SizedBox(height: sizeBoxHeight),
              Text(
                'Price: ${product.price} \$',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              SizedBox(height: sizeBoxHeight),
              BoutonFavoriAkPanye(
                userId: userId,
                productId: product.id,
              ),
              SizedBox(height: sizeBoxHeight),
              Text(
                product.description!,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
