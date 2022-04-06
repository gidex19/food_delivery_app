
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:food_app/data/data.dart';
import 'package:food_app/models/order.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({ Key? key }) : super(key: key);



  _buildRecentOrder(BuildContext context, Order order){

    return Container(
      // padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.all(10),
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.1))),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              height: 100,
              width: 100,
              image: AssetImage(order.food!.imageUrl),
              fit: BoxFit.cover,),
          ),
          Container(
              margin: EdgeInsets.all(6),
              width: MediaQuery.of(context).size.width/2.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(order.food!.name, style: GoogleFonts.montserrat( textStyle : TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
                    overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 4,),  
                  Text(order.restaurant!.name, style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 4,),  
                  Text(order.date, style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis, ),
                    
                ],
              ),
            ),
          
          // Expanded(child: Container(),),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 20),
              // padding: EdgeInsets.only(right: 20),
              width: 50,
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
      ),  
    );
  }

  @override
  

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Recent Orders',
          style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16) ),
        )),
        Container(
          height: 120,
          // color: Colors.blue,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: currentUser.orders?.length,
            itemBuilder: (BuildContext context, int index){
              Order order = currentUser.orders![index];
              return  _buildRecentOrder(context, order);
            }),
        )
      ],
        
    );
  }
}