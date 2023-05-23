import 'package:flutter/material.dart';
import './Kategori.dart';
import './BoutonPeye.dart';
import './AfficheLisPwodwi.dart';
import './AfficheLisPwodwiAkAppBar.dart';
import './Konekte.dart';
import 'package:provider/provider.dart';
import 'done/lokal.dart';
import './done/api.dart';
import 'model/User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child : MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true,
        ),
        home: Akey(),
      )
    );
  }
}

class MyAppState extends ChangeNotifier {
  MyAppState() {
    //eseye konekte ak done ki anrejistre an lokal pou itilizate a
    konekteItilizateLokal();
  }

  User? _itilizate;

  //verifye si yon itilizate konekte
  bool siItilizateKonekte() {
    return _itilizate != null;
  }

  //Anrejistre koneksyon pou yon itilizate
  Future<void> konekte(User itilizate) async {
    _itilizate = itilizate;
    //mete itilizate ki konekete a nan yon fichye
    await Storage.anrejistreItilizate(_itilizate!);
    notifyListeners();
  }

  //dekonekte yon itilizate
  Future<void> dekonekte() async {
    _itilizate = null;
    //siprimer itilizate ki konekte a nan fichye a
    await Storage.siprrimeItilizate();
    notifyListeners();
  }

  //rekipere itilizate ki konekte a
  User? rekipereItilizate() {
    return _itilizate;
  }

  //chaje itilizate ki anrejistre an local la
  Future<void> konekteItilizateLokal() async {
    //rekipere itlizate ki an local la
    User? itilizate = await Storage.rekipereItilizate();
    if (itilizate != null) {
      konekte(itilizate);
    }
  }
}


class Akey extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AkeyState();
  }
}

class _AkeyState extends State<Akey>{

  late int _index;
  late List<Widget> _liswidget;
  late Widget _widgetAktyel;
  late Key _kle;

  @override
  void initState(){
    super.initState();
    _index = 1;
    _liswidget = [_Panye(),_Akey(),_Favori()];
    _widgetAktyel = _liswidget[_index];
    _kle = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    MyAppState state = context.watch<MyAppState>();
    TextStyle style = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 300,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: state.siItilizateKonekte() ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("LJ ComeS",style: style,),
                    SizedBox(height: 20,),
                    CircleAvatar(
                      radius: 30,
                      child :Icon(Icons.account_circle),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      " ${state.rekipereItilizate()!.username}",
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                    ),
                  ],
                ) : Text("LJ ComeS",style: style,),
              ),
            ),
            ListTile(
              title: Text("Konekte"),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (ctx){ return Konekte();}
                )
                );
              },
              enabled: !state.siItilizateKonekte(),
            ),
            ListTile(
              title: Text("Lis Pwodwi"),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                    builder: (ctx){ return AficherLisPwodwiAkAppBar(rekiperePwodwi: APIService.rekipereLisPwodwi,);}
                )
                );
              },
            ),
            ListTile(
              title: Text("Dekonekte"),
              onTap: (){
                state.dekonekte();
                setState(() {
                  //rafrechi paj la
                  _kle = UniqueKey();
                });
              },
              enabled: state.siItilizateKonekte(),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("LJ ComeS",style: style,),
        actions: [
          BoutonPeye(),
        ],
      ),
      body: Container(
        key: _kle,
        child : _widgetAktyel,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _index = index;
            _widgetAktyel = _liswidget[_index];
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}

class _Akey extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child:SingleChildScrollView(
        child:Column(
          children: [
            Text("Kategori ki plis chache",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
            LisKategori(rekipereCategori: APIService.rekipereTopKategori,),
            Text("Prodwi yo achete plis",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.white,)),
            LisPwodwi(rekiperePwodwi: APIService.rekipereTopPwodwi),
          ],
        ),
      )
    );
  }

}

class _Panye extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    MyAppState state = context.watch<MyAppState>();
    if(state.siItilizateKonekte()){
      return LisPwodwi(rekiperePwodwi: () {
        return Storage.rekiperePwodwiKiNanPanye(state.rekipereItilizate()!.id);
      });
    }
    else{
      return LisPwodwi(rekiperePwodwi: () {
        return Storage.rekiperePwodwiKiNanPanye(-1);
      });
    }
  }
}

class _Favori extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    MyAppState state = context.watch<MyAppState>();
    if(state.siItilizateKonekte()){
      return  LisPwodwi(rekiperePwodwi: () {
        return Storage.rekiperePwodwiFavori(state.rekipereItilizate()!.id);
      });
    }
    else{
      return  LisPwodwi(rekiperePwodwi: () {
        return Storage.rekiperePwodwiFavori(-1);
      });
    }
  }
}