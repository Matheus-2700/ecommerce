import 'package:ecommerce/const/screen/calendarScree..dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/controller/cartController.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 230, 85, 131),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Text(
              'Seu carrinho está vazio!',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        return ListView(
          children: cartController.cartItems.keys.map((productName) {
            final quantity = cartController.cartItems[productName]!;
            final unitPrice = cartController.productPrices[productName]!;
            final totalPrice = quantity * unitPrice;
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(productName),
                subtitle: Text(
                  'R\$ ${unitPrice.toStringAsFixed(2)} x $quantity = R\$ ${totalPrice.toStringAsFixed(2)}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        cartController.removeFromCart(productName);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        cartController.addToCart(productName);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        cartController.removeItem(productName);
                        Get.snackbar(
                          'Produto Removido',
                          '$productName foi removido do carrinho.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      }),
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total: R\$ ${cartController.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (cartController.cartItems.isNotEmpty) {
                    // Navega para a tela de agendamento
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PickupCalendarScreen(),
                      ),
                    );
                  } else {
                    Get.snackbar(
                      'Carrinho vazio',
                      'Adicione itens antes de finalizar o pedido!',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: const Text('Finalizar Pedido'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
