import 'package:localstorage/localstorage.dart';
import '../model/Product.dart';
import '../model/User.dart';
import './api.dart';

class Storage {
  static String _file = "fakestoreapi.json";
  static String _favKey = "fav";
  static String _shopKey = "shop";
  static String _userKey = "user";
  static LocalStorage _storage = LocalStorage(_file);

  static Future<void> anrejistreItilizate(User user) async {
    await _storage.ready;
    await _storage.setItem(_userKey, user.toMap());
  }

  static Future<void> siprrimeItilizate() async {
    await _storage.ready;
    await _storage.deleteItem(_userKey);
  }

  static Future<User?> rekipereItilizate() async {
    await _storage.ready;
    Map<String, dynamic>? userData = await _storage.getItem(_userKey);
    if (userData != null) {
      return User.fromMap(userData);
    }
    return null;
  }

  //rekipere tout pwodwi ki nan favori
  static Future<List<Product>> rekiperePwodwiFavori(int userId) async {
    await _storage.ready;
    List<dynamic> idList = await _storage.getItem("$userId$_favKey") ?? [];
    final List<Product> lisPwodwi = await APIService.rekipereLisPwodwi();
    lisPwodwi.retainWhere((element) => idList.contains(element.id));
    return lisPwodwi;
  }

  //ajoute ou byen retire nan favori
  static Future<void> toggleProductInFav(int userId, dynamic value) async {
    await _storage.ready;
    List<dynamic> idList = await _storage.getItem("$userId$_favKey") ?? [];
    if (idList.contains(value)) {
      idList.remove(value);
    } else {
      idList.add(value);
    }
    await _storage.setItem("$userId$_favKey", idList);
  }

  //verifye si yon pwodwi nan favori
  static Future<bool> siPwodwiNanFavori(int userId, int productId) async {
    await _storage.ready;
    List<dynamic> idList = await _storage.getItem("$userId$_favKey") ?? [];
    return idList.contains(productId);
  }

  //rekipere tout pwodwi ki nan panye
  static Future<List<Product>> rekiperePwodwiKiNanPanye(int userId) async {
    await _storage.ready;
    List<dynamic> idList = await _storage.getItem("$userId$_shopKey") ?? [];
    final List<Product> lisPwodwi = await APIService.rekipereLisPwodwi();
    lisPwodwi.retainWhere((element) => idList.contains(element.id));
    return lisPwodwi;
  }

  //ajoute ou byen retire nan panye
  static Future<void> toggleProductInShop(int userId, dynamic value) async {
    await _storage.ready;
    List<dynamic> idList = await _storage.getItem("$userId$_shopKey") ?? [];
    if (idList.contains(value)) {
      idList.remove(value);
    } else {
      idList.add(value);
    }
    await _storage.setItem("$userId$_shopKey", idList);
  }

  //verifye si yon pwodwi nan panye
  static Future<bool> siPwodwiNanPanye(int userId, int productId) async {
    await _storage.ready;
    List<dynamic> idList = await _storage.getItem("$userId$_shopKey") ?? [];
    return idList.contains(productId);
  }
}
