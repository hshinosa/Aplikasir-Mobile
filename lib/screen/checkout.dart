import 'package:aplikasir/screen/checkout_berhasil.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String amount = '0';
  bool isCredit = false;
  final int totalAmount = 74000; // Store the total amount

  void onNumberPressed(String value) {
    setState(() {
      if (amount == '0') {
        amount = value;
      } else {
        amount += value;
      }
    });
  }

  void onClearPressed() {
    setState(() {
      amount = '0';
    });
  }

  void onBackspacePressed() {
    setState(() {
      if (amount.isNotEmpty) {
        amount = amount.substring(0, amount.length - 1);
        if (amount.isEmpty) {
          amount = '0';
        }
      }
    });
  }

  // Check if entered amount matches total
  bool isAmountMatching() {
    try {
      final enteredAmount = int.parse(amount.replaceAll('.', ''));
      return enteredAmount >= totalAmount;
    } catch (e) {
      return false;
    }
  }

  // Navigate to success screen
  void navigateToSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutTransaksiBerhasil(),
      ),
    );
  }

  Widget buildKeyButton(String label, {VoidCallback? onPressed}) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed ?? () => onNumberPressed(label),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showConfirmButton = isAmountMatching();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                  ),
                  Spacer(),
                  Center(
                    child: Text(
                      'Transaksi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),

              const SizedBox(height: 20),
              // Amount Display
              Text(
                'Total : Rp ${totalAmount.toString().replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]}.',
                    )}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Rp ${amount == '0' ? '0' : amount.replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]}.',
                  )}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              // Credit Checkbox
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Row(
                  children: [
                    Checkbox(
                      value: isCredit,
                      onChanged: (bool? value) {
                        setState(() {
                          isCredit = value ?? false;
                        });
                      },
                    ),
                    const Text('Kredit'),
                  ],
                ),
              ),
              // Custom Keypad Grid
              Expanded(
                child: Column(
                  children: [
                    // Row 1: 7 8 9 C
                    Expanded(
                      child: Row(
                        children: [
                          buildKeyButton('7'),
                          buildKeyButton('8'),
                          buildKeyButton('9'),
                          buildKeyButton('C', onPressed: onClearPressed),
                        ],
                      ),
                    ),
                    // Row 2: 4 5 6 ⌫
                    Expanded(
                      child: Row(
                        children: [
                          buildKeyButton('4'),
                          buildKeyButton('5'),
                          buildKeyButton('6'),
                          buildKeyButton('⌫', onPressed: onBackspacePressed),
                        ],
                      ),
                    ),
                    // Row 3: 1 2 3 ✓
                    Expanded(
                      child: Row(
                        children: [
                          buildKeyButton('1'),
                          buildKeyButton('2'),
                          buildKeyButton('3'),
                          if (showConfirmButton)
                            Expanded(
                              child: TextButton(
                                  onPressed: navigateToSuccess,
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Image.asset(
                                    'assets/icons/Check.png',
                                    height: 40,
                                    width: 40,
                                  )),
                            )
                          else
                            const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                    // Row 4: 0 000 .
                    Expanded(
                      child: Row(
                        children: [
                          buildKeyButton('0'),
                          buildKeyButton('000'),
                          buildKeyButton('.'),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
