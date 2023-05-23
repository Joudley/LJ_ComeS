import 'package:flutter/material.dart';
import './AfficheLisPwodwiAkAppBar.dart';
import './done/api.dart';
import 'model/Category.dart';

class LisKategori extends StatefulWidget {
  final Future<List<Category>> Function() rekipereCategori;

  LisKategori({Key? key, required this.rekipereCategori}) : super(key: key);

  @override
  _LisKategoriState createState() => _LisKategoriState();
}

class _LisKategoriState extends State<LisKategori> {
  late Future<List<Category>> _lisKategori;
  late Key _key;

  @override
  void initState() {
    super.initState();
    _lisKategori = widget.rekipereCategori();
    _key = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Category>>(
        key: _key,
        future: _lisKategori,
        builder: (context, categoryList) {
          if (categoryList.hasData) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoryList.data!.map((category) => _Kategori(category: category)).toList(),
              ),
            );
          } else if (categoryList.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${categoryList.error}"),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      //refresh paj la
                      setState(() {
                        _lisKategori = widget.rekipereCategori();
                        _key = UniqueKey();
                      });
                    },
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class _Kategori extends StatelessWidget {
  final Category category;

  _Kategori({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => AficherLisPwodwiAkAppBar(
              rekiperePwodwi: () {
                return APIService.rekiperePwodwiPaKategori(category.title);
              },
            ),
          ),
        );
      },
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.category_outlined),
              Text(category.title, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}
