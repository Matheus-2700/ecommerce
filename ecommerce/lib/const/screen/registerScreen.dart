import 'package:ecommerce/controller/longinController.dart';
import 'package:ecommerce/controller/userController.dart'; // Importa o UserController
import 'package:flutter/material.dart'; // Importa widgets do Flutter
import 'package:get/get.dart'; // Importa o GetX para gerenciamento de estado

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave global para o formulário
  final UserController controller = Get.put(UserController(),
      permanent:
          true); // Inicializa o UserController e o mantém no sistema de injeção de dependência
  bool _isLoading =
      false; // Estado de carregamento para exibir um indicador de progresso

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Define a cor de fundo da tela
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.blue, // Define a cor do appbar
        centerTitle: true, // Centraliza o título do appbar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 50), // Espaço extra no topo
              _buildNameField(), // Constrói o campo de nome
              const SizedBox(height: 20), // Espaço vertical
              _buildEmailField(), // Constrói o campo de e-mail
              const SizedBox(height: 20), // Espaço vertical
              _buildPasswordField(), // Constrói o campo de senha
              const SizedBox(height: 40), // Espaço vertical maior
              _isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Exibe um indicador de progresso se estiver carregando
                  : _buildRegisterButton(), // Constrói o botão de registro
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar o campo de nome
  Widget _buildNameField() {
    return TextFormField(
      controller: controller
          .nameController, // Controlador de texto para o campo de nome
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'Enter your name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name'; // Validação para campo vazio
        }
        return null;
      },
    );
  }

  // Função para criar o campo de e-mail
  Widget _buildEmailField() {
    return TextFormField(
      controller: controller
          .emailController, // Controlador de texto para o campo de e-mail
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      keyboardType:
          TextInputType.emailAddress, // Define o tipo de teclado para e-mail
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email'; // Validação para campo vazio
        } else if (!GetUtils.isEmail(value)) {
          return 'Invalid email format'; // Validação para formato de e-mail inválido
        }
        return null;
      },
    );
  }

  // Função para criar o campo de senha
  Widget _buildPasswordField() {
    return TextFormField(
      controller: controller
          .passwordController, // Controlador de texto para o campo de senha
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      obscureText: true, // Oculta o texto da senha
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password'; // Validação para campo vazio
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters'; // Validação para senha curta
        }
        return null;
      },
    );
  }

  // Função para criar o botão de registro
  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed:
          _registerUser, // Chama a função de registro ao pressionar o botão
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent, // Define a cor do botão
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
        ),
      ),
      child: const Text(
        'Register',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  // Função para registrar o usuário
  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Exibe o indicador de progresso durante o registro
      });

      // Obtém os valores dos controladores de texto
      final name = controller.nameController.text;
      final email = controller.emailController.text;
      final password = controller.passwordController.text;

      try {
        final usercontroller = UserController(); // Instancia o UserController
        final userId = await usercontroller.insertUser(
            name, email, password); // Insere o usuário no banco de dados
        if (userId != 0) {
          // Login automático após o registro bem-sucedido
          final logincontroller =
              LoginController(); // Instancia o LoginController
          await logincontroller.getUserByEmailAndPassword(
              email, password); // Autentica o usuário
          // Redireciona para a tela inicial após o login bem-sucedido
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration failed. Email already in use?'),
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } finally {
        setState(() {
          _isLoading =
              false; // Oculta o indicador de progresso após a tentativa de registro
        });
      }
    }
  }

  @override
  void dispose() {
    controller.nameController.dispose(); // Dispose do controlador de nome
    controller.emailController.dispose(); // Dispose do controlador de e-mail
    controller.passwordController.dispose(); // Dispose do controlador de senha
    super.dispose();
  }
}
