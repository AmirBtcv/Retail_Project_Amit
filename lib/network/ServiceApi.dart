

import 'package:amit_final_project/model/Cartresponse.dart';
import 'package:amit_final_project/model/CategoryResponse.dart';
import 'package:amit_final_project/model/ErrorResponse.dart';
import 'package:amit_final_project/model/ProductRespone.dart';
import 'package:amit_final_project/model/User.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' ;
import 'package:amit_final_project/network/Urls.dart';
import 'dart:convert' as convert;




class ServiceApi {
  static int statuscode=0;

 ServiceApi._();

static final ServiceApi instance = ServiceApi._();




  Future<String> register (User user) async{
    // var convert;
    Response res = await post(Uri.parse(REGISTER_URL),
        body:convert.jsonEncode(user)

        ,
    headers: {"Content-type" : "application/json"});
    statuscode = res.statusCode;
    if (res.statusCode == 201) {
      return convert.jsonDecode(res.body)["token"] ;
    }
    else
      {
        ErrorResponse errorResponse =
        ErrorResponse.fromJson(convert.jsonDecode(res.body));
      return errorResponse.message;
      }

  }


  Future<String> login(User user) async{
    Response res=await post(Uri.parse(LOGIN_URL),
    body: convert.jsonEncode(user),headers: {"Content-type" : "application/json"});
    statuscode=res.statusCode;
    if(res.statusCode==200){
      return convert.jsonDecode(res.body)["token"];

    }else {
      return convert.jsonDecode(res.body)["error"];

    }
  }


  Future<ProductResponse> getProducts() async{
    Response res = await get(Uri.parse(GET_PRODUCTS_URL));
    statuscode = res.statusCode;
    if(res.statusCode == 200){
      return ProductResponse.fromJson(convert.jsonDecode(res.body));
    }else {
      return convert.jsonDecode(res.body)["message"];

    }
  }




  Future<CategoryResponse> getCategories() async{
    Response res = await get(Uri.parse(GET_CATEGORIES_URL));
    statuscode = res.statusCode;
    if(res.statusCode == 200){
      return CategoryResponse.fromJson(convert.jsonDecode(res.body));
    }else {
      return convert.jsonDecode(res.body)["message"];

    }
  }

Future <CartResponse> getCart (String token) async{
    Response res=await get(Uri.parse(CART_URL),headers: {'Authorization':'Bearer $token'});
    statuscode = res.statusCode;
    if(res.statusCode==200){
      return CartResponse.fromJson(convert.jsonDecode(res.body));

    }else {
      return convert.jsonDecode(res.body)["message"];
    }
}

  Future <String> addToCart({String token, String productId, int amount}) async{

        Response res = await put(Uri.parse(getAddToCartUrl(productId: productId )),
        headers: {'Authorization':'Bearer $token'},
            body: {"amount": "$amount"});
        statuscode = res.statusCode;

        return convert.jsonDecode(res.body)["message"];
  }
}

