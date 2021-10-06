import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// 1. Behavior in widgets
class ButtonDemo1 extends StatelessWidget {
  const ButtonDemo1({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.green,
        child: const Text("click me"),
      ),
    );
  }
}

/// 2. Hello world
class HomePageDemo2 extends StatelessWidget {
  const HomePageDemo2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Hello World!"),
    );
  }
}

/// 3. With an animation
class HomePageDemo3 extends StatefulWidget {
  const HomePageDemo3({Key? key}) : super(key: key);

  @override
  State<HomePageDemo3> createState() => _HomePageDemo3State();
}

class _HomePageDemo3State extends State<HomePageDemo3> {
  bool isOpaque = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text("Cast a spell"),
            onPressed: () {
              setState(() => isOpaque = !isOpaque);
            },
          ),
          const SizedBox(height: 16),
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: isOpaque ? 1 : 0,
            child: const Text("Peek a boo"),
          ),
        ],
      ),
    );
  }
}

/// 4. With accessibility & asynchronicity
class Order {
  final String customerName;
  final String item;

  const Order({required this.customerName, required this.item});
}

const order = Order(customerName: "Abhay", item: "coffee");

class HomePageDemo4 extends StatelessWidget {
  const HomePageDemo4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Order>(
          future: Future.delayed(const Duration(seconds: 5), () {
            SemanticsService.announce("New order received", TextDirection.ltr);
            return order;
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final order = snapshot.data!;
              return Semantics(
                key: const ValueKey("order_semantics"),
                label: "${order.item} for ${order.customerName}",
                child: ExcludeSemantics(
                  child: Text("${order.customerName}: ${order.item}"),
                ),
              );
            } else {
              return const Text("No orders received yet");
            }
          }),
    );
  }
}

/// 4. Asphalt Aloha 💖 Flutter
/// https://source.golabs.io/asphalt/asphalt-aloha-flutter/
