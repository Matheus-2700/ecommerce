import 'package:ecommerce/const/screen/paymentScreen.dart'; // Importa a tela de pagamento
import 'package:flutter/material.dart'; // Importa pacotes necessários para a interface do Flutter
import 'package:table_calendar/table_calendar.dart'; // Importa o widget TableCalendar

class PickupCalendarScreen extends StatefulWidget {
  // Tela que permite ao usuário selecionar um dia e horário para retirada
  const PickupCalendarScreen({super.key});

  @override
  _PickupCalendarScreenState createState() => _PickupCalendarScreenState();
}

class _PickupCalendarScreenState extends State<PickupCalendarScreen> {
  // Variáveis para armazenar o dia focado e o dia/horário selecionados
  DateTime _focusedDay = DateTime
      .now(); // Armazena o dia atualmente em foco (mostrado no calendário)
  DateTime? _selectedDay; // Armazena o dia selecionado pelo usuário
  TimeOfDay? _selectedTime; // Armazena o horário selecionado pelo usuário

  // Função que abre o seletor de horário
  void _showTimeDialog() async {
    // Mostra o seletor de hora e armazena o horário escolhido
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Inicializa com a hora atual
    );

    // Se o usuário selecionar um horário, atualiza o estado
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime; // Armazena o horário selecionado
      });
    }
  }

  // Função para proceder para a tela de pagamento
  void _proceedToPayment() {
    // Verifica se o usuário selecionou tanto o dia quanto o horário
    if (_selectedDay == null || _selectedTime == null) {
      // Exibe um aviso caso algum dos dois não tenha sido selecionado
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione o dia e o horário de retirada.'),
        ),
      );
      return; // Retorna sem fazer nada se não houver seleção de dia/horário
    }

    // Navega para a tela de pagamento com os dados selecionados (dia e horário)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          selectedDate:
              _selectedDay!, // Passa o dia selecionado para a tela de pagamento
          selectedTime:
              _selectedTime!, // Passa o horário selecionado para a tela de pagamento
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Função build, que define o layout da tela
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamento de Retirada'), // Título da tela
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Adiciona espaçamento entre os widgets
        child: Column(
          children: [
            // Widget TableCalendar que exibe um calendário interativo
            TableCalendar(
              focusedDay: _focusedDay, // Define o dia atualmente em foco
              firstDay: DateTime.now(), // Data inicial (hoje)
              lastDay: DateTime.utc(
                  2030, 12, 31), // Data final (último dia do ano 2030)
              calendarFormat: CalendarFormat
                  .month, // Define o formato do calendário (mês atual)
              selectedDayPredicate: (day) => isSameDay(_selectedDay,
                  day), // Verifica se o dia é o mesmo que o selecionado
              onDaySelected: (selectedDay, focusedDay) {
                // Função chamada quando o usuário seleciona um dia no calendário
                setState(() {
                  _selectedDay = selectedDay; // Armazena o dia selecionado
                  _focusedDay = focusedDay; // Atualiza o dia em foco
                });
                _showTimeDialog(); // Abre o seletor de horário
              },
              calendarStyle: const CalendarStyle(
                // Estilos para o calendário
                todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle), // Decoração para o dia de hoje
                selectedDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle), // Decoração para o dia selecionado
              ),
            ),
            const SizedBox(
                height: 20), // Adiciona um espaço entre o calendário e o botão
            ElevatedButton(
              onPressed:
                  _proceedToPayment, // Chama a função de pagamento quando pressionado
              child:
                  const Text('Confirmar e Ir para Pagamento'), // Texto do botão
            ),
          ],
        ),
      ),
    );
  }
}
