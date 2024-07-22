// import 'dart:convert';
// import 'package:dams_cash/models/product.dart';
// import 'package:http/http.dart' as http;

// class ProductRepository{
//   final _baseUrl = 'https://668f732280b313ba09182f6a.mockapi.io/api/product';

//   Future getData() async {
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));

//       if(response.statusCode==200){
//         Iterable it = jsonDecode(response.body);
//         List<Product> product = it.map((e)=> Product.fromJson(e)).toList();
//         return product;
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

// }