import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<String> images = [
    'assets/images/beijinho.jpg',
    'assets/images/brigadeiro.jpg',
    'assets/images/casadinho.jpg',
    'assets/images/coco.jpg',
    'assets/images/damasco.jpg',
    'assets/images/nutela.jpg',
  ];

  final List<double> imageHeights = [100, 160, 150, 120, 180, 160];
  final List<double> imageWidths = [100, 160, 150, 120, 180, 160];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: const Text('DOCES'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 230, 85, 131),
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
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                children: List.generate(images.length, (index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: imageHeights[index],
                          width: imageWidths[index],
                          child: Image.asset(
                            images[index],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.calendar_month),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
