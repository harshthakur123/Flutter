import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class CurrencyConverterCupertinoPage extends StatefulWidget {
  const CurrencyConverterCupertinoPage({super.key});

  @override
  State<CurrencyConverterCupertinoPage> createState() =>
      _CurrencyConverterCupertinoPageState();
}

class _CurrencyConverterCupertinoPageState
    extends State<CurrencyConverterCupertinoPage> {
  final CurrencyConverterViewModel viewModel = CurrencyConverterViewModel();
  TextEditingController textEditingController = TextEditingController();

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

    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 52, 45, 45),
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 90, 72, 102),
        middle: Text(
          "Currency Converter",
          style: TextStyle(color: Colors.white),
        ),
      ),
      child: Center(
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
                  // Button for conversion
                  ElevatedButton(
                    onPressed: () {
                      String input = textEditingController.text.trim();
                      setState(() {
                        viewModel.convert(
                            input); // Call the convert method from ViewModel
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(255, 52, 45, 45),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        const Text("Convert", style: TextStyle(fontSize: 18)),
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
