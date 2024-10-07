import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cartProvider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  //Provider
  //StreamProvider
  //FutureProvider
  //ChangeNotifierProvider

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cartprovider>().cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: cart.isEmpty
          ? const Center(
              // Display this when cart is empty
              child: Text(
                "Your Cart Is Empty",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cartItem = cart[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                    radius: 45,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Delete Product",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: Text(
                                "Are you sure, do you want to remove this product from you cart",
                                style: Theme.of(context).textTheme.bodySmall),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<Cartprovider>()
                                      .removeProduct(cartItem);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
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
