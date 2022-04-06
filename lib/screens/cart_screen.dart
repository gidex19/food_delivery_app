// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_function_literals_in_foreach_calls, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food_app/data/data.dart';
import 'package:food_app/models/order.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  _buildCartItem(Order order) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 170,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(children: <Widget>[
              Container(
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(order.food!.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        order.food!.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        order.restaurant!.name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.8, color: Colors.black54,),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){},
                              child: Text('-',
                              style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
                            ),
                            SizedBox(width: 20,),
                            Text(order.quantity.toString(),
                            style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),),
                            SizedBox(width: 20,),
                            GestureDetector(
                              onTap: () {
                                
                              },
                              child: Text('+',
                              style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
          Text('\$${order.quantity! * order.food!.price}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cart!.forEach(
      (Order order)=> 
      totalPrice+=(order.quantity! * order.food!.price));

    return Scaffold(
        appBar: AppBar(
          title: Text('Cart (${currentUser.cart!.length})'),
        ),
        body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: currentUser.cart!.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if(index<currentUser.cart!.length){
              Order order = currentUser.cart![index];
              return _buildCartItem(order);}
            else{
              return Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Estimated Delivery Time',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                        Text('30min',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    SizedBox(height: 10,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Cost:',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                        Text('\$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.green),),
                      ],
                    ),
                    SizedBox(height: 100,),
                  ],
                ),
              );
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            );
          },
        ),
        bottomSheet: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 6
            )
            ],
          ),
          child: Center(
            child: FlatButton(onPressed: () {  },
            child: Text('CHECKOUT', 
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ),
          ),
        ),
        );
  }
}
