import 'package:ecommerce/const/screen/calendarScree..dart'; // Importa a tela de calendário para agendamento de retirada
import 'package:flutter/material.dart'; // Importa pacotes necessários para a interface do Flutter
import 'package:get/get.dart'; // Importa o GetX para gerenciamento de estado e navegação
import 'package:ecommerce/controller/cartController.dart'; // Importa o controller do carrinho de compras

class CartScreen extends StatelessWidget {
  // Obtém o controller do carrinho usando GetX (get.find() encontra a instância já criada)
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar da tela com título e cor de fundo
      appBar: AppBar(
        title: const Text('Carrinho'), // Título da tela
        centerTitle: true, // Centraliza o título
        backgroundColor: const Color.fromARGB(
            255, 230, 85, 131), // Cor personalizada do app bar
      ),
      body: Obx(() {
        // Obx é utilizado para atualizar a UI quando a lista de itens no carrinho muda
        if (cartController.cartItems.isEmpty) {
          // Caso o carrinho esteja vazio
          return const Center(
            child: Text(
              'Seu carrinho está vazio!', // Exibe uma mensagem quando não há itens no carrinho
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        // Caso contrário, exibe a lista de itens no carrinho
        return ListView(
          children: cartController.cartItems.keys.map((productName) {
            // Para cada produto no carrinho, exibe as informações
            final quantity =
                cartController.cartItems[productName]!; // Quantidade do produto
            final unitPrice = cartController
                .productPrices[productName]!; // Preço unitário do produto
            final totalPrice = quantity *
                unitPrice; // Cálculo do preço total (quantidade * preço unitário)
            return Card(
              margin: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5), // Margem para o card
              child: ListTile(
                title: Text(productName), // Nome do produto
                subtitle: Text(
                  'R\$ ${unitPrice.toStringAsFixed(2)} x $quantity = R\$ ${totalPrice.toStringAsFixed(2)}', // Exibe o preço unitário, a quantidade e o total
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Botão para remover uma unidade do produto do carrinho
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        cartController.removeFromCart(
                            productName); // Chama o método para remover uma unidade
                      },
                    ),
                    // Botão para adicionar uma unidade do produto ao carrinho
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        cartController.addToCart(
                            productName); // Chama o método para adicionar uma unidade
                      },
                    ),
                    // Botão para remover completamente o produto do carrinho
                    IconButton(
                      icon: const Icon(Icons.delete,
                          color: Colors.red), // Ícone de deletar (vermelho)
                      onPressed: () {
                        cartController.removeItem(
                            productName); // Remove o item do carrinho
                        // Exibe uma mensagem confirmando a remoção
                        Get.snackbar(
                          'Produto Removido',
                          '$productName foi removido do carrinho.',
                          snackPosition: SnackPosition
                              .BOTTOM, // Exibe o snack bar na parte inferior
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }).toList(), // Converte os itens do carrinho para uma lista de widgets
        );
      }),
      bottomNavigationBar: Obx(() {
        // Obx é utilizado aqui para atualizar a UI quando o total de preço mudar
        return Padding(
          padding: const EdgeInsets.all(
              8.0), // Adiciona espaçamento ao redor do conteúdo
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // O conteúdo ocupará apenas o espaço necessário
            children: [
              // Exibe o preço total formatado
              Text(
                'Total: R\$ ${cartController.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18, // Define o tamanho da fonte
                  fontWeight: FontWeight.bold, // Define a fonte em negrito
                ),
              ),
              // Botão de "Finalizar Pedido"
              ElevatedButton(
                onPressed: () {
                  if (cartController.cartItems.isNotEmpty) {
                    // Se o carrinho não estiver vazio, navega para a tela de agendamento
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const PickupCalendarScreen(), // Tela de agendamento de retirada
                      ),
                    );
                  } else {
                    // Caso o carrinho esteja vazio, exibe um aviso
                    Get.snackbar(
                      'Carrinho vazio',
                      'Adicione itens antes de finalizar o pedido!', // Mensagem de erro
                      snackPosition: SnackPosition
                          .BOTTOM, // Exibe o snack bar na parte inferior
                    );
                  }
                },
                child: const Text('Finalizar Pedido'), // Texto do botão
              ),
            ],
          ),
        );
      }),
    );
  }
}
