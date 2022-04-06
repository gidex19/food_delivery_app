// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  // const RatingStars({ Key? key }) : super(key: key);

  late final int rating;
  
  RatingStars(this.rating);
  
  @override
  Widget build(BuildContext context) {
    String stars = '';
      for(int i=0; i<rating; i++){
        stars += '🌟 ';
      }
      stars.trim();
    return Text(stars, 
    style: TextStyle(fontSize: 12),);
  }
}