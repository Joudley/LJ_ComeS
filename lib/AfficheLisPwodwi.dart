import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import './DetayPwodwi.dart';
import 'FavoriPanyeBtn.dart';
import 'model/Product.dart';

class LisPwodwi extends StatefulWidget {
  final Future<List<Product>> Function() rekiperePwodwi;

  LisPwodwi({Key? key, required this.rekiperePwodwi}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LisPwodwiState();
  }
}

class _LisPwodwiState extends State<LisPwodwi> {
  late Future<List<Product>> _lisPwodwi;
  late Key _kle;

  @override
  void initState() {
    super.initState();
    _lisPwodwi = widget.rekiperePwodwi();
    _kle = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();
    return FutureBuilder<List<Product>>(
      key: _kle,
      future: _lisPwodwi,
      builder: (context, lispwodwi) {
        if (lispwodwi.hasData) {
          if (lispwodwi.data!.isEmpty) {
            return Center(
              child: Text(
                "Lis pwodwi an vid",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 20,
                crossAxisSpacing: 1,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 0.5,
                padding: EdgeInsets.all(5),
                children: lispwodwi.data!.map((pwodwi) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return DetayPwodwi(
                              product: pwodwi, userId: appState.siItilizateKonekte() ? appState.rekipereItilizate()!.id : -1,
                            );
                          },
                        ),
                      ).whenComplete(() {
                        //rafrechi
                        setState(() {
                          _kle = UniqueKey();
                        });
                      });
                    },
                    child: _Pwodwi(
                      product: pwodwi,
                      userId: appState.siItilizateKonekte() ? appState.rekipereItilizate()!.id : -1,
                    ),
                  );
                }).toList(),
              ),
            );
          }
        } else if (lispwodwi.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${lispwodwi.error}"),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    //rafrechi
                    setState(() {
                      _lisPwodwi = widget.rekiperePwodwi();
                      _kle = UniqueKey();
                    });
                  },
                  child: Text("Retry"),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _Pwodwi extends StatelessWidget {
  final int userId;
  final Product product;

  _Pwodwi({required this.product, required this.userId});

  @override
  Widget build(BuildContext context) {
    const double height = 5;
    return SizedBox(
      height: double.infinity,
      child: Card(
        color: Colors.yellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.image!,
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: height),
                  Text(
                    product.description!,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${product.price} \$",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  BoutonFavoriAkPanye(
                    userId: userId,
                    productId: product.id,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
