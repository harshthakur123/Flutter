import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cartProvider.dart';
import 'package:shop_app/pages/home_page.dart'; // Import the HomePage

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _orderPlaced = false;
  bool _showContinueButton = false; // State to control the button visibility
  double _buttonOpacity = 0.0; // State to control button opacity for fade-in

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _confirmOrder() {
    if (Provider.of<Cartprovider>(context, listen: false).cart.isNotEmpty) {
      // Clear the cart
      Provider.of<Cartprovider>(context, listen: false).clearCart();

      // Start the animation
      _controller.forward();
      setState(() {
        _orderPlaced = true; // Show order placed message
      });

      // Show the continue shopping button after the animation
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _showContinueButton = true; // Show the button after animation
          _buttonOpacity = 1.0; // Set button opacity to fully visible
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cartprovider>(context).cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _orderPlaced
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _animation,
                      child: Icon(
                        Icons.check_circle,
                        size: 100,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Order Placed!",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    // Fade-in animation for the continue shopping button
                    AnimatedOpacity(
                      opacity: _buttonOpacity,
                      duration: const Duration(
                          seconds: 1), // Duration for the fade-in effect
                      child: ElevatedButton(
                        onPressed: () {
                          // Redirect to the HomePage
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Continue Shopping",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        return ListTile(
                          title: Text(item['title']),
                          subtitle: Text(
                              "Price: ₹${item['price']} x ${item['quantity']}"),
                          trailing: Text(
                              "Total: ₹${item['price'] * item['quantity']}"),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _confirmOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Confirm Order",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
