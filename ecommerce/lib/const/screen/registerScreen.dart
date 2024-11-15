import 'package:ecommerce/controller/loginController.dart';
import 'package:ecommerce/controller/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave do formulário
  final UserController controller =
      Get.put(UserController(), permanent: true); // Usar permanent: true
  bool _isLoading = false; // Controle do estado de carregamento

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Cor de fundo neutra
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor:
            Colors.blue, // Cor do appbar mais adequada para app de doces
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 50), // Espaço extra no topo
              _buildNameField(),
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 40),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar o campo de nome
  Widget _buildNameField() {
    return TextFormField(
      controller: controller.nameController,
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
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  // Função para criar o campo de email
  Widget _buildEmailField() {
    return TextFormField(
      controller: controller.emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email';
        } else if (!GetUtils.isEmail(value)) {
          return 'Invalid email format';
        }
        return null;
      },
    );
  }

  // Função para criar o campo de senha
  Widget _buildPasswordField() {
    return TextFormField(
      controller: controller.passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  // Função para criar o botão de registro
  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _registerUser,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent, // Cor do botão
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
        _isLoading = true; // Mostrar o carregando enquanto registra
      });

      // Obtém os valores dos controladores
      final name = controller.nameController.text;
      final email = controller.emailController.text;
      final password = controller.passwordController.text;

      try {
        final usercontroller = UserController();
        final userId = await usercontroller.insertUser(name, email, password);
        if (userId != 0) {
          // Login automático após o registro bem-sucedido
          final logincontroller = LoginController();
          await logincontroller.getUserByEmailAndPassword(email, password);
          // Redireciona para a tela inicial após o login bem-sucedido
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Registration failed. Email already in use?')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } finally {
        setState(() {
          _isLoading =
              false; // Ocultar o carregando após a tentativa de registro
        });
      }
    }
  }

  @override
  void dispose() {
    controller.nameController.dispose();
    controller.emailController.dispose();
    controller.passwordController.dispose();
    super.dispose();
  }
}
