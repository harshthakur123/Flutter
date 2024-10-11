import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Image.asset(
          item['imageUrl'], // Adjust based on your item structure
          width: 50,
        ),
        title: Text(item['title']),
        subtitle: Text(
            '₹${item['price']} x ${item['quantity']}'), // Assuming you have a quantity field
        trailing:
            Text('₹${item['price'] * item['quantity']}'), // Total for the item
      ),
    );
  }
}
