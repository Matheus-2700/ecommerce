import 'package:ecommerce/const/screen/cartScreen.dart'; // Importa a tela de carrinho de compras
import 'package:ecommerce/controller/cartController.dart'; // Importa o controller do carrinho
import 'package:flutter/material.dart'; // Importa os pacotes necessários para o Flutter
import 'package:get/get.dart'; // Importa o GetX para gerenciamento de estado e navegação

class HomeScreen extends StatelessWidget {
  // Instancia o controller do carrinho usando Get.put() para que ele seja gerenciado pelo GetX
  final CartController cartController = Get.put(CartController());

  // Lista de imagens dos doces
  final List<String> images = [
    'assets/images/beijinho.jpg',
    'assets/images/brigadeiro.jpg',
    'assets/images/casadinho.jpg',
    'assets/images/coco.jpg',
    'assets/images/damasco.jpg',
    'assets/images/nutela.jpg',
  ];

  // Lista de nomes dos doces
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
      // Cor de fundo da tela principal
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: const Text('DOCES'), // Título da AppBar
        centerTitle: true, // Centraliza o título
        backgroundColor: const Color.fromARGB(
            255, 230, 85, 131), // Cor de fundo personalizada para a AppBar
        actions: [
          // Ícone do carrinho na AppBar
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Quando o ícone do carrinho for pressionado, navega para a tela do carrinho
              Get.to(() => CartScreen());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
            1.0), // Adiciona padding em torno do conteúdo da tela
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinha os itens ao início da coluna
          children: [
            const Center(
              child: Text(
                'Bem vindo!!!', // Texto de boas-vindas
                style: TextStyle(
                  fontSize: 28, // Tamanho da fonte
                  fontWeight: FontWeight.bold, // Estilo de fonte em negrito
                ),
              ),
            ),
            const SizedBox(height: 20), // Espaçamento entre os widgets
            const Center(
              child: Text(
                'Escolha seus doces favoritos', // Texto instrutivo para o usuário
                style: TextStyle(
                  fontSize: 22, // Tamanho da fonte
                  color: Colors.black87, // Cor do texto
                ),
              ),
            ),
            const SizedBox(height: 20), // Mais espaçamento
            Expanded(
              // Usado para tornar a GridView expansível dentro da tela
              child: GridView.count(
                // GridView com 2 colunas
                crossAxisCount: 2,
                crossAxisSpacing: 2, // Espaçamento horizontal entre as colunas
                mainAxisSpacing: 2, // Espaçamento vertical entre as linhas
                children: List.generate(images.length, (index) {
                  // Para cada item na lista de imagens, cria um widget
                  return GestureDetector(
                    // Detecta o toque no item da grid
                    onTap: () {
                      // Quando o item é tocado, adiciona ao carrinho
                      cartController.addToCart(productNames[index]);
                      // Exibe uma notificação com o nome do produto adicionado ao carrinho
                      Get.snackbar(
                        'Produto Adicionado',
                        '${productNames[index]} foi adicionado ao carrinho.',
                        snackPosition: SnackPosition
                            .BOTTOM, // Exibe a mensagem na parte inferior
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            5), // Define bordas arredondadas no card
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Alinha os itens dentro do card
                        children: [
                          // Exibe a imagem do doce
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(images[index]),
                          ),
                          const SizedBox(height: 10), // Espaçamento
                          Text(
                            productNames[index], // Nome do doce
                            style: const TextStyle(
                              fontSize: 16, // Tamanho da fonte
                              fontWeight:
                                  FontWeight.bold, // Estilo de fonte em negrito
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
        // Botão flutuante no canto inferior direito da tela
        onPressed: () {
          // Quando o botão flutuante é pressionado, navega para a tela do carrinho
          Get.to(() => CartScreen());
        },
        backgroundColor: Colors.green, // Cor de fundo do botão
        child: const Icon(
            Icons.shopping_cart), // Ícone do carrinho dentro do botão
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Define a localização do botão flutuante
    );
  }
}
