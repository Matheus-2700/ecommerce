import 'package:ecommerce/const/screen/cartScreen.dart';
import 'package:ecommerce/controller/cartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  final List<String> images = [
    'assets/images/beijinho.jpg',
    'assets/images/brigadeiro.jpg',
    'assets/images/casadinho.jpg',
    'assets/images/coco.jpg',
    'assets/images/damasco.jpg',
    'assets/images/nutela.jpg',
  ];

  final List<String> productNames = [
    'Beijinho',
    'Brigadeiro',
    'Casadinho',
    'Coco',
    'Damasco',
    'Nutela',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: const Text('DOCES'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 230, 85, 131),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartScreen());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Bem vindo!!!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Escolha seus doces favoritos',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                children: List.generate(images.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      cartController.addToCart(productNames[index]);
                      Get.snackbar(
                        'Produto Adicionado',
                        '${productNames[index]} foi adicionado ao carrinho.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(images[index]),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            productNames[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CartScreen());
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
