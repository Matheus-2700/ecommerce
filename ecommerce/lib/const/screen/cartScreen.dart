import 'package:ecommerce/controller/cartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = cartController.cartItems[index];
            return ListTile(
              title: Text(cartItem.product.name),
              subtitle: Text('Preço: R\$${cartItem.product.price}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      cartController.removeFromCart(cartItem);
                    },
                  ),
                  Text('${cartItem.quantity}'), // Quantidade atual
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      cartController.addToCart(cartItem.product);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          padding: EdgeInsets.all(16),
          child: Text(
            'Total: R\$${cartController.totalPrice}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      }),
    );
  }
}
