// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, unused_import, avoid_function_literals_in_foreach_calls, unnecessary_import, avoid_print, unused_local_variable, annotate_overrides, await_only_futures

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_app/data/data.dart';
import 'package:food_app/models/food.dart';
import 'package:food_app/screens/cart_screen.dart';
import 'package:food_app/screens/restaurant_screen.dart';
import 'package:get/get.dart';
import 'package:food_app/models/restaurant.dart';
import 'package:food_app/widgets/rating_stars.dart';
import 'package:food_app/widgets/recent_orders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

final itemsRef = FirebaseFirestore.instance.collection("items");
final restaurantsRef = FirebaseFirestore.instance.collection("restaurants");
final foodsRef = FirebaseFirestore.instance.collection("foods");
final ordersRef = FirebaseFirestore.instance.collection("orders");

final burrito = Food(
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/food-delivery-d6417.appspot.com/o/burrito.jpg?alt=media&token=c683ce37-79fc-49f6-a2f8-08615a46a410',
    name: 'Burrito',
    price: 8.99);
final steak = Food(
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/food-delivery-d6417.appspot.com/o/steak.jpg?alt=media&token=7abd539b-4ef7-44da-9040-5b53c83564de',
    name: 'Steak',
    price: 17.99);
final pasta = Food(
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/food-delivery-d6417.appspot.com/o/pasta.jpg?alt=media&token=29fc3fc5-0b3d-4c93-bf91-eff88327f0e0',
    name: 'Pasta',
    price: 14.99);
final ramen = Food(
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/food-delivery-d6417.appspot.com/o/ramen.jpg?alt=media&token=91cc3309-71c0-4adf-bce5-debe8dd1a60e',
    name: 'Ramen',
    price: 13.99);
final pancakes = Food(
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/food-delivery-d6417.appspot.com/o/pancakes.jpg?alt=media&token=5cca3d3b-faed-42ee-b821-87ef9bd7a087',
    name: 'Pancakes',
    price: 9.99);
final burger = Food(
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/food-delivery-d6417.appspot.com/o/burger.jpg?alt=media&token=1628758e-f4d0-4fb9-84b4-dad9fa7fdd99',
    name: 'Burger',
    price: 14.99);
final pizza = Food(
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/food-delivery-d6417.appspot.com/o/pizza.jpg?alt=media&token=c0a9a66c-70e4-47b7-9954-1d6d0a3c071d',
    name: 'Pizza',
    price: 11.99);
final salmon = Food(
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/food-delivery-d6417.appspot.com/o/salmon.jpg?alt=media&token=9c879f6b-c69d-45e4-a1a2-da3d405cc763',
    name: 'Salmon Salad',
    price: 12.99);

final foodList = [
  burrito,
  steak,
  pasta,
  ramen,
  pancakes,
  burger,
  pizza,
  salmon
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Restaurant> allRestaurants = [];

  _buildRestaurants() {
    List<Widget> restaurantList = [];
    restaurants.forEach((Restaurant restaurant) {
      restaurantList.add(GestureDetector(
        onTap: () {
          debugPrint('clicked just now');
          Get.to(() => RestaurantScreen(restaurant: restaurant));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1,
                color: Colors.grey.withOpacity(0.2),
              )),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  tag: restaurant.imageUrl,
                  child: Image(
                    height: 150,
                    width: 150,
                    image: AssetImage(restaurant.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      RatingStars(restaurant.rating),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        restaurant.address,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '0.5 miles away',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    });
    return Column(children: restaurantList);
  }

  // addItems()async{
  //   print("running the add item function");
  //   foodList.forEach((element) async{

  //   return await foodsRef.doc("tYhayWMTvuc6ontfCc6e").collection("restFood").doc().set(
  //     {
  //     'name': element.name,
  //     'price': element.price,
  //     'imageUrl': element.imageUrl,
  //     'ownerId': "tYhayWMTvuc6ontfCc6e",
  //   }).then((value) => print("item added to DB")).catchError((e)=>{print(e)});
  //   });
  // }

  // addItems()async{
  //   QuerySnapshot<Map<String, dynamic>> foods = await foodsRef.get();
  //   Iterable<Map<String, dynamic>> foodlist = foods.docs.map((doc)=>doc.data()).toList();
  //   print(foodlist.first['name']);

  // }
  getRestId() async {
    QuerySnapshot<Map<String, dynamic>> rstsDoc = await restaurantsRef.get();
  }

  printFoods() async {
    print("print food is function already running");
    QuerySnapshot<Map<String, dynamic>> foodsDoc =
        await foodsRef.doc("tYhayWMTvuc6ontfCc6e").collection("restFood").get();
    Iterable<Map<String, dynamic>> idList =
        foodsDoc.docs.map((e) => e.data()).toList();
    print(idList.first['price']);
    debugPrint("running function");
  }

  List<String> first = [
    "1I92I1lKmgtVAhZbkHpj",
    "2L55TRlJsJwZn3NeNh5u",
    "JHzaC2ajlVQC1zHq1mgQ",
    "Kbog0fk7BAakwkI7Oacz",
    "PGq9n4caosFxffgcMR9f",
    "R4xLXlKKcmH9bhzKaSKq",
    "YSsNPnpnAx74fZ92j9wC",
    "phgWytM5fzVGmm5C2NsZ"
  ];

  getRestaurants() async {
    QuerySnapshot<Map<String, dynamic>> rstsDoc = await restaurantsRef.get();

    List<Map<String, dynamic>> rstsList =
        await rstsDoc.docs.map((doc) => doc.data()).toList();

    // print(rstsList);
    for (Map<String, dynamic> rest in rstsList) {
      // print(rest['id']);
      String idRest = rest['id'];
      List<String> idMenu =
          (rest['menu'] as List).map((e) => e as String).toList();
      print(rest['menu']);
      print("within getrestaurants");
      print(idRest);
      print(idMenu);
      print(idMenu.runtimeType);

      // await foodStringToFoodClass("ZiH48mekBegMpKjjgSlS", first);
    }

    // method one
    // for (Map item in rstsList) {
    //   print(item);
    // }

    // Future.forEach(rstsList, (element) async{

    //   List<Food> menuList =await useNorm(elemen ['id'].toString(), element['menu']);
    //   print("menuList");
    //   print(menuList);
    //   Restaurant restaurantClass = Restaurant(imageUrl: element['imageUrl'], name: element['name'],
    //    address: element['address'], rating: element['rating'], menu: menuList);
    //   allRestaurants.add(restaurantClass);
    //   // print("new restaurant class");
    //   // print(restaurantClass);
    // });
    // print(allRestaurants);
  }

  // String restId, List<String> foodIdList
  foodStringToFoodClass() async {
    List<Food> foodClassList = [];
    // await Future.forEach(menuId, (element) async {
    //   DocumentSnapshot<Map<String, dynamic>> foodItem = await foodsRef
    //       .doc("tYhayWMTvuc6ontfCc6e")
    //       .collection("restFood")
    //       .doc(element.toString())
    //       .get();
    //   Food foodClass = Food.fromDocument(foodItem);
    //   print("food class");
    //   print(foodClass.name);
    //   foodClassList.add(foodClass);
    // });

    // starts here
    for (String item in menuId) {
      print("within the loop");
      DocumentSnapshot<Map<String, dynamic>> foodItem = await foodsRef
          .doc("tYhayWMTvuc6ontfCc6e")
          .collection("restFood")
          .doc(item.toString())
          .get();

      Food foodClass = Food.fromDocument(foodItem);
      print("food class");
      print(foodClass.name);
      foodClassList.add(foodClass);
    }
    print("use norm function");
    print(foodClassList);
    return foodClassList;
  }

  List<String> menuId = [
    "71OkbnEyBwnORfr8nHSd",
    "9TVIDOvIFMY2kGeDRJ2k",
    "Bgr1GhO31WWdNSM6wZQd",
    "KEDSF9kCaDhui2owwccL",
    "Q06lPAi0MjnPW8Ar6pMy",
    "dUHD3sThnRzj6S6mVVOS",
    "dzkOyCgyXBohlhYFD20G",
    "vkOnc2y7b5vNy8spXxB5"
  ];

  void getFoods(String restId, List<String> foodIdList) async {
    List<Food> foodClassList = [];
    foodIdList.forEach((element) async {
      DocumentSnapshot<Map<String, dynamic>> foodItem =
          await foodsRef.doc(restId).collection("restFood").doc(element).get();
      Food foodClass = Food.fromDocument(foodItem);
      // print(foodClass);
      foodClassList.add(foodClass);
    });
    print(foodClassList);
  }

// [ 71OkbnEyBwnORfr8nHSd, 9TVIDOvIFMY2kGeDRJ2k, Bgr1GhO31WWdNSM6wZQd,  KEDSF9kCaDhui2owwccL, Q06lPAi0MjnPW8Ar6pMy,  dUHD3sThnRzj6S6mVVOS,  dzkOyCgyXBohlhYFD20G,  vkOnc2y7b5vNy8spXxB5]
  @override
  void initState() {
    super.initState();

    print("state has been re run");
  }

  // getFoods("tYhayWMTvuc6ontfCc6e", menuId)
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.account_circle),
            iconSize: 30.0,
            onPressed: foodStringToFoodClass),
        title: Text('Food Delivery UI'),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Text(
              'Cart (${currentUser.cart?.length})',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            onPressed: () {
              Get.to(() => CartScreen());
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(width: 0.8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                        width: 0.8, color: Theme.of(context).primaryColor),
                  ),
                  hintText: 'Search Food or Restaurants',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {},
                    iconSize: 25,
                  )),
            ),
          ),
          RecentOrders(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Nearby Restaurants',
                    style: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ),
              _buildRestaurants(),
            ],
          )
        ],
      ),
    );
  }
}
