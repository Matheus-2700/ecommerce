import 'package:ecommerce/const/screen/paymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PickupCalendarScreen extends StatefulWidget {
  const PickupCalendarScreen({super.key});

  @override
  _PickupCalendarScreenState createState() => _PickupCalendarScreenState();
}

class _PickupCalendarScreenState extends State<PickupCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? _selectedTime;

  void _showTimeDialog() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _proceedToPayment() {
    if (_selectedDay == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione o dia e o horário de retirada.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          selectedDate: _selectedDay!,
          selectedTime: _selectedTime!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendamento de Retirada')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 12, 31),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _showTimeDialog(); // Abre o diálogo de horário
              },
              calendarStyle: const CalendarStyle(
                todayDecoration:
                    BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                selectedDecoration:
                    BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _proceedToPayment,
              child: const Text('Confirmar e Ir para Pagamento'),
            ),
          ],
        ),
      ),
    );
  }
}
