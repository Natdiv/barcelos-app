import 'dart:convert';
import 'package:http/http.dart' as http;

class ItemsModel {
  ItemsModel(
      {required this.foodDescription,
      required this.foodName,
      required this.foodPrice,
      required this.foodRate,
      required this.foodImage});

  final String foodName;
  final String foodDescription;
  final double foodPrice;
  final int foodRate;
  final String foodImage;
  static String url = 'https://baarcelosh.000webhostapp.com/vegi_backend_29/public/';

  static List<dynamic> itemsFromServer = [];

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      foodRate: 4,
      foodPrice: double.parse(json['sale_price']),
      foodName: json['name'],
      foodDescription: json['description'],
      foodImage: url + json['image']
    );
  }

  static Future<ItemsModel> fetchOneItems() async {
    final response = await http
        .get(Uri.parse('https://baarcelosh.000webhostapp.com/barcelosapi/empty_vergi_product.php'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return ItemsModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<dynamic> fetchItems() async {
    final response = await http
        .get(Uri.parse('https://baarcelosh.000webhostapp.com/barcelosapi/empty_vergi_product.php'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(jsonDecode(response.body)['data'].runtimeType);
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static List<ItemsModel> buildListItemsFromJson(List<dynamic> json) {
    List<ItemsModel> list = [];
    for(var i = 0; i < json.length; i++) {
      list.add(ItemsModel.fromJson(json[i]));
    }
    return list;
  }
}
