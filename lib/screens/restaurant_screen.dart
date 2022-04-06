// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, deprecated_member_use, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:food_app/models/food.dart';
import 'package:food_app/models/restaurant.dart';
import 'package:food_app/widgets/rating_stars.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantScreen extends StatefulWidget {
  
  late final Restaurant restaurant;

  RestaurantScreen({
    required this.restaurant
  });

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  _buildMenuItem(Food menuItem){
    return Center(child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(menuItem.imageUrl),
              fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15)
          )
        ),
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topRight, end: Alignment.bottomLeft,
            colors:[
             Colors.black.withOpacity(0.3),
             Colors.black87.withOpacity(0.3),
             Colors.black54.withOpacity(0.3),
             Colors.black38.withOpacity(0.3),],
             stops: [
               0.1,
               0.4,
               0.6,
               0.9
             ]
             )),
        ),
        Positioned(
          bottom: 65,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(menuItem.name, 
              style: TextStyle(letterSpacing: 1.2, fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              Text('\$${menuItem.price.toString()}',
              style: TextStyle(letterSpacing: 1.2, fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Positioned(
          bottom: 10, right: 10,
          child: Container(
              // margin: EdgeInsets.only(right: 20),
              // padding: EdgeInsets.only(right: 20),
              // width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                icon: Icon(Icons.add),
                iconSize: 30,
                color: Colors.white,
                onPressed: (){},
              ),
            ),
        )
      ],
    ));

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:<Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: widget.restaurant.imageUrl,
                child: Image(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  image: AssetImage(widget.restaurant.imageUrl),
                  fit: BoxFit.cover,),
              ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton( 
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed:() {
                          print('back clicked');
                          debugPrint('back clicked');
                          Get.back();
                        },
                        color: Colors.white,
                        iconSize: 30,),
                        IconButton( 
                        icon: Icon(Icons.favorite),
                        onPressed:() {
                          print('fav clicked');
                          debugPrint('fav clicked');
                        },
                        color: Theme.of(context).primaryColor,
                        iconSize: 30,)
                    ],
                  ),
                ),
                
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:20, bottom: 10, left: 20, right: 20),
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(widget.restaurant.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,)),
                          Text('0.2 miles away', style: TextStyle(fontSize: 14)),
                        ]
                      ),
                      RatingStars(widget.restaurant.rating),
                      SizedBox(height: 6,),
                      Text(widget.restaurant.address, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
                    ]
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(onPressed: (){},
               color: Theme.of(context).primaryColor,
               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(40)
               ),
               child: Text('Reviews', 
              style: TextStyle(fontSize: 16, color: Colors.white),)),

              FlatButton(onPressed: (){},
               color: Theme.of(context).primaryColor,
               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(40)
               ),
               child: Text('Contact', 
              style: TextStyle(fontSize: 16, color: Colors.white),))
            ],
          ),
          SizedBox(height: 10,),
          Center(child: Text('Menu', 
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 1.2)),),
          SizedBox(height: 0,),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(widget.restaurant.menu.length, (index){
                Food food = widget.restaurant.menu[index];
                return _buildMenuItem(food);
              }),),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 5, left: 20, right: 20),
        width: 120,
        height: 60,
        decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.4)
        ),
        child: Column(children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("2 Items in cart ||", style: GoogleFonts.montserrat(
                  textStyle: TextStyle(fontWeight: FontWeight.bold,))),
                Text(" Total: N45,000", style: GoogleFonts.montserrat(
                  textStyle: TextStyle(fontWeight: FontWeight.bold))),
                RaisedButton(
                  // icon: Icon(Icons.c),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: (){},
                    child: Text("Cart"),)  

              ],),
              
          ],),
        )


    );
  }
}