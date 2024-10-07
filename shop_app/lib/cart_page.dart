import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cartProvider.dart';
import 'package:shop_app/global_variables.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  //Provider
  //StreamProvider
  //FutureProvider
  //ChangeNotifierProvider

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cartprovider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final cartItem = cart[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                radius: 45,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 255, 17, 0),
                ),
              ),
              title: Text(
                cartItem['title'].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size : ${cartItem['size']}'),
            );
          }),
    );
  }
}
