import 'package:ecommerce/controller/cartController.dart';
import 'package:ecommerce/controller/loginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final List<String> images = [
    'assets/images/beijinho.jpg',
    'assets/images/brigadeiro.jpg',
    'assets/images/casadinho.jpg',
    'assets/images/coco.jpg',
    'assets/images/damasco.jpg',
    'assets/images/nutela.jpg',
  ];

  final List<double> imageHeights = [30, 60, 50, 40, 60, 60];
  final List<double> imageWidths = [30, 60, 50, 40, 60, 60];

  final CartController cartController =
      Get.find(); // Obtém o controlador do carrinho
  final ProductController productController =
      Get.find(); // Obtém o controlador de produtos

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: const Text('DOCES'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 230, 85, 131),
      ),
      body: Obx(() {
        if (productController.products.isEmpty) {
          return Center(
              child:
                  CircularProgressIndicator()); // Mostra um indicador de progresso enquanto os produtos carregam
        }

        return Padding(
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
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  children:
                      List.generate(productController.products.length, (index) {
                    final product = productController.products[index];
                    return GestureDetector(
                      // Adicione GestureDetector para detectar cliques
                      onTap: () {
                        cartController
                            .addToCart(product); // Adiciona o item ao carrinho
                        Navigator.pushNamed(
                            context, '/cart'); // Navega para a tela de carrinho
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10), // Defina o raio desejado aqui
                              child: SizedBox(
                                height:
                                    imageHeights[index % imageHeights.length],
                                width: imageWidths[index % imageWidths.length],
                                child: Image.asset(
                                  images[index % images.length],
                                  fit: BoxFit
                                      .cover, // Ajusta a imagem ao tamanho do widget
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.calendar_month),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
