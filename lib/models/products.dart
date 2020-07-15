import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, id;
  final Color color;
  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.color,
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "Apple",
      price: 100,
      description: dummyText,
      image: "images/apple.jpg",
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "Grapes",
      price: 100,
      description: dummyText,
      image: "images/grapes.jpg",
      color: Color(0xFFD3A984)),
  Product(
      id: 3,
      title: "Pineapple",
      price: 100,
      description: dummyText,
      image: "images/pineapple.jpg",
      color: Color(0xFF989493)),
  Product(
      id: 4,
      title: "Tomatoe",
      price: 100,
      description: dummyText,
      image: "images/tomato.jpg",
      color: Color(0xFFE6B398)),
  Product(
      id: 5,
      title: "Veg",
      price: 100,
      description: dummyText,
      image: "images/veg.jpg",
      color: Color(0xFFFB7883)),
  Product(
    id: 6,
    title: "Frozen",
    price: 100,
    description: dummyText,
    image: "images/frozen.jpg",
    color: Color(0xFFAEAEAE),
  ),

];


String dummyText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";