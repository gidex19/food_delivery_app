import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String imageUrl;
  final String name;
  final double price;
  String ownerId = "23456666";
  
  

  Food({
    required this.imageUrl,
    required this.name,
    required this.price,
    
  });


  factory Food.fromDocument(DocumentSnapshot doc){
    return Food(
      name : doc['name'],
      price: doc['price'],
      imageUrl: doc['imageUrl']
      // ownerId: doc['ownerId']);
    );
  
}
}