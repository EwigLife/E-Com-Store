import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_app/config.dart';
import 'package:wordpress_app/model/loginModel.dart';
import 'package:wordpress_app/model/products.dart';
import 'model/category.dart';
import 'model/customer.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode(Config.key + ':' + Config.secret),
    );

    bool ret = false;

    try{
      var response = await Dio().post(
        Config.url + Config.customerURL,
        data: model.toJson(),
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
          HttpHeaders.contentTypeHeader: 'application/json'}
        )
      );

      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e){
      if(e.response.statusCode == 404) {
        ret = false;
      }
      else{
        ret = false;
      }
    }
    return ret;
  }

  Future<LoginResponseModel> loginCustomer(String username, String password) async {
    LoginResponseModel model;

    try {

      var response = await Dio().post(
        Config.tokenURL,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/x-www0form-urlencoded',
          }
        )
      );
      if(response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.data); 
      }
    } on DioError catch(e) {
      print(e.message);
    }
    return model;
  }
  Future<List<Category>> getCategories() async {
    List<Category> data = List<Category>();

    try {
      String url = Config.url + 
      Config.categoriesURL + 
      '?consumer_key=${Config.key}&consumer_secret=${Config.secret}';
      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }
        )
      );
      if (response.statusCode == 200) {
        data = (response.data as List).map((i) => Category.fromJson(i),).toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }

  Future<List<Product>> getProducts({
    int pageSize,
    int pageNumber,
    String strSearch,
    String tagName,
    String categoryId,
    String sortBy,
    String sortOrder = "asc",
    }) async {
    List<Product> data = new List<Product>();

    try {

      String parameter = '';

      if(strSearch != null) {
        parameter += '&search=$strSearch';
      }

      if(pageSize != null) {
        parameter += '&sper_page=$pageSize';
      }

      if(pageNumber != null) {
        parameter += '&page=$pageNumber';
      }

      if(tagName != null) {
        parameter += '&tag=$tagName';
      }

      if(categoryId != null) {
        parameter += '&category=$categoryId';
      }

      if(sortBy != null) {
        parameter += '&sortby=$sortBy';
      }

      if(sortOrder != null) {
        parameter += '&order=$sortOrder';
      }
      String url = Config.url + Config.productURL + '?consumer_key=${Config.key}&consumer_secret=${Config.secret}${parameter.toString()}';
      var response = await Dio().get(url,
      options: Options(
        headers:{
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      data = (response.data as List).map(
        (i) => Product.fromJson(i),
      )
      .toList();
     }
     }on DioError catch (e){
       print(e.response);
     }
     return data;

    
  }
}