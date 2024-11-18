import 'package:flutter/material.dart'; // Importa widgets do Flutter
import 'package:get/get.dart'; // Importa o GetX para gerenciamento de estado

class PaymentScreen extends StatelessWidget {
  final DateTime selectedDate; // Data selecionada para retirada
  final TimeOfDay selectedTime; // Hora selecionada para retirada

  const PaymentScreen({
    required this.selectedDate,
    required this.selectedTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagamento')), // Título da appbar
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding para o corpo da tela
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinha os widgets no início
          children: [
            // Exibe a data de retirada formatada
            Text(
              'Data de Retirada: ${selectedDate.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 18),
            ),
            // Exibe o horário de retirada formatado
            Text(
              'Horário de Retirada: ${selectedTime.format(context)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Texto explicativo para o método de pagamento
            const Text(
              'Escolha o Método de Pagamento:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Botão de pagamento via PIX
            ElevatedButton(
              onPressed: () {
                // Exibe o diálogo de confirmação para o pagamento via PIX
                Get.defaultDialog(
                  title: 'Pedido Finalizado!', // Título do diálogo
                  content: const Text(
                      'Você escolheu pagar com PIX.\nObrigado por sua compra!'),
                  onConfirm: () =>
                      Get.offAllNamed('/home'), // Volta para a tela inicial
                  textConfirm: 'OK', // Texto do botão de confirmação
                );
              },
              child: const Text('PIX'), // Texto do botão de PIX
            ),
            const SizedBox(height: 10),
            // Botão de pagamento via Dinheiro na Retirada
            ElevatedButton(
              onPressed: () {
                // Exibe o diálogo de confirmação para o pagamento em dinheiro
                Get.defaultDialog(
                  title: 'Pedido Finalizado!', // Título do diálogo
                  content: const Text(
                      'Você escolheu pagar com Dinheiro.\nObrigado por sua compra!'),
                  onConfirm: () =>
                      Get.offAllNamed('/home'), // Volta para a tela inicial
                  textConfirm: 'OK', // Texto do botão de confirmação
                );
              },
              child: const Text(
                  'Dinheiro na Retirada'), // Texto do botão de Dinheiro na Retirada
            ),
          ],
        ),
      ),
    );
  }
}
