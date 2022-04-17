import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/src/model/product.dart';
import 'package:machine_test/src/utility/status.dart';
class ProductProvider extends ChangeNotifier{



  List<Product>productList=[];
  ProviderStatus status=ProviderStatus.IDLE;

  getProducts() async {
    productList.clear();
    status=ProviderStatus.LOADING;
    notifyListeners();
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      print('success');
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List items=jsonDecode(response.body);
      items.forEach((element) {
        productList.add(Product.fromJson(element));
      });
      status=ProviderStatus.LOADED;
      notifyListeners();
      productList.forEach((element) {
        print("price"+element.price.toString());
        print("rating"+element.rating!.rate.toString());
      });
      print(status.index.toString());
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      status=ProviderStatus.ERROR;
      notifyListeners();
      throw Exception('Failed to load album');
    }
  }
}

