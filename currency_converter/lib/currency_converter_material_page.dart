import 'package:flutter/material.dart';

// ViewModel class to handle conversion logic
class CurrencyConverterViewModel {
  String result = '';

  void convert(String input) {
    if (input.isEmpty) {
      result = "Please enter a number!";
    } else {
      try {
        double inputValue = double.parse(input);
        result = "INR ${inputValue * 81}";
      } catch (e) {
        result = "Enter a valid number!";
      }
    }
  }
}

// Currency Converter App
class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State createState() => _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage>
    with SingleTickerProviderStateMixin {
  final CurrencyConverterViewModel viewModel = CurrencyConverterViewModel();
  TextEditingController textEditingController = TextEditingController();
  double _scaleFactor = 1.0; // To control the scale of the button

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 45, 45),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 90, 72, 102),
        elevation: 10,
        title: const Text(
          "Currency Converter",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Display the conversion result
                  Text(
                    viewModel.result.isNotEmpty ? viewModel.result : "INR 0",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: textEditingController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: "Enter amount in USD",
                        hintStyle:
                            TextStyle(color: Color.fromARGB(153, 0, 0, 0)),
                        prefixIcon: Icon(Icons.monetization_on),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: border,
                        enabledBorder: border,
                        contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Animated Convert button
                  GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        _scaleFactor = 0.9; // Scale down
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _scaleFactor = 1.0; // Scale back up
                      });
                      // Trigger conversion after scaling back
                      String input = textEditingController.text.trim();
                      setState(() {
                        viewModel.convert(
                            input); // Call the convert method from ViewModel
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _scaleFactor = 1.0; // Scale back up if tap is cancelled
                      });
                    },
                    child: AnimatedScale(
                      scale: _scaleFactor,
                      duration: const Duration(milliseconds: 100),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 90, 72, 102),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Convert",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
