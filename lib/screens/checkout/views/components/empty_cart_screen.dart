import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/screen_export.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Theme.of(context).brightness == Brightness.light
                    ? "assets/Illustration/empty_cart.png"
                    : "assets/Illustration/empty_cart_dark.png",
                height: MediaQuery.of(context).size.height * 0.25,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.shopping_cart_outlined,
                    size: 120,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.3),
                  );
                },
              ),
              const SizedBox(height: defaultPadding * 2),
              Text(
                "Your cart is empty",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: defaultPadding / 2),
              Text(
                "Looks like you haven't added anything to your cart yet",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: defaultPadding * 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    entryPointScreenRoute,
                    (route) => false,
                  );
                },
                child: const Text("Start Shopping"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

