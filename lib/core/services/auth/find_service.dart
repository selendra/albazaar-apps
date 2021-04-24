import 'package:albazaar_app/all_export.dart';
import 'package:flutter/material.dart';

class FindingServices {

  String findPaymentById(String id, List<Map<String, dynamic>> paymentsList){
    int i = 0;
    for (; i < paymentsList.length; i++){
      if (id == paymentsList[i]['id']) break;
    }

    if (i == paymentsList.length) return null;

    return paymentsList[i]['options_name'];
  }

  String findCategoryById(String id, List<Map<String, dynamic>> categoriesList){
    int i = 0;
    for (; i < categoriesList.length; i++){
      if (id == categoriesList[i]['id']) break;
    }

    if (i == categoriesList.length) return null;

    return categoriesList[i]['category_name'];
  }

  String findShippingById(String id, List<Map<String, dynamic>> shippingList){
    int i = 0;
    for (; i < shippingList.length; i++){
      if (id == shippingList[i]['id']) break;
    }

    if (i == shippingList.length) return null;

    return shippingList[i]['shipping_service'];
  }
  
  String findScaleById(String id, List<Map<String, dynamic>> scalesList){
    int i = 0;
    for (; i < scalesList.length; i++){
      if (id == scalesList[i]['id']) break;
    }

    if (i == scalesList.length) return null;

    return scalesList[i]['weight_option'];
  }
}