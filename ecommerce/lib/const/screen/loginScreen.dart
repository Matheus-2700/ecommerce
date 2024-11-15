import 'package:ecommerce/controller/loginController.dart'; // Importa o controlador para login
import 'package:flutter/material.dart'; // Importa os pacotes necessários para o Flutter
import 'package:get/get.dart'; // Importa o GetX para gerenciamento de estado e navegação

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); // Construtor da tela de login

  @override
  _LoginScreenState createState() =>
      _LoginScreenState(); // Criação do estado para a tela de login
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey =
      GlobalKey<FormState>(); // Chave para o formulário, usada para validação
  final LoginController controller =
      Get.put(LoginController()); // Instancia o controlador do login com GetX
  bool _isLoading =
      false; // Variável para controlar o estado de carregamento do login

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Cor de fundo branca para a tela de login
      appBar: AppBar(
        title: const Text('Login'), // Título da appbar
        backgroundColor: Colors.blue, // Cor de fundo da appbar
        centerTitle: true, // Centraliza o título na appbar
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20.0), // Padding para dar espaçamento na tela
        child: Form(
          key: _formKey, // Atribui a chave do formulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Alinha os widgets na largura total
            children: <Widget>[
              const SizedBox(height: 50), // Espaço no topo antes dos campos
              _buildEmailField(), // Função para criar o campo de email
              const SizedBox(
                  height: 20), // Espaço entre o campo de email e o de senha
              _buildPasswordField(), // Função para criar o campo de senha
              const SizedBox(height: 40), // Espaço entre os campos e os botões
              _isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Exibe o indicador de progresso enquanto está carregando
                  : _buildLoginButton(), // Exibe o botão de login se não estiver carregando
              const SizedBox(height: 20), // Espaço entre os botões
              _buildRegisterButton(), // Função para criar o botão de registro
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar o campo de email
  Widget _buildEmailField() {
    return TextFormField(
      controller:
          controller.emailController, // Controlador para o campo de email
      decoration: InputDecoration(
        labelText: 'Email', // Texto da label do campo
        hintText:
            'Digite seu email', // Texto que aparece no campo quando está vazio
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
          borderSide: BorderSide(color: Colors.blueAccent), // Cor da borda
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 15, horizontal: 20), // Padding interno do campo
      ),
      keyboardType:
          TextInputType.emailAddress, // Define o tipo de teclado para email
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um email'; // Mensagem de erro se o campo estiver vazio
        } else if (!GetUtils.isEmail(value)) {
          return 'Formato de email inválido'; // Valida se o email está no formato correto
        }
        return null; // Retorna null se a validação for bem-sucedida
      },
    );
  }

  // Função para criar o campo de senha
  Widget _buildPasswordField() {
    return TextFormField(
      controller:
          controller.passwordController, // Controlador para o campo de senha
      decoration: InputDecoration(
        labelText: 'Senha', // Texto da label do campo
        hintText:
            'Digite sua senha', // Texto que aparece no campo quando está vazio
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
          borderSide: BorderSide(color: Colors.blueAccent), // Cor da borda
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 15, horizontal: 20), // Padding interno do campo
      ),
      obscureText: true, // Esconde a senha enquanto o usuário digita
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira uma senha'; // Mensagem de erro se o campo estiver vazio
        } else if (value.length < 6) {
          return 'A senha deve ter pelo menos 6 caracteres'; // Valida o comprimento mínimo da senha
        }
        return null; // Retorna null se a validação for bem-sucedida
      },
    );
  }

  // Função para criar o botão de login
  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          // Valida o formulário antes de continuar
          setState(() {
            _isLoading = true; // Ativa o estado de carregamento
          });
          bool success = await controller
              .loginUser(); // Chama o método de login no controlador
          setState(() {
            _isLoading = false; // Desativa o estado de carregamento
          });
          if (success) {
            Get.offAllNamed(
                '/home'); // Se o login for bem-sucedido, navega para a tela inicial
          } else {
            Get.snackbar(
              'Falha no login',
              'Credenciais inválidas', // Exibe uma mensagem de erro se o login falhar
              snackPosition:
                  SnackPosition.BOTTOM, // Exibe a mensagem na parte inferior
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Cor de fundo do botão
        padding: const EdgeInsets.symmetric(vertical: 15), // Padding no botão
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
        ),
      ),
      child: const Text(
        'Login', // Texto do botão
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  // Função para criar o botão de registro
  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
            context, '/register'); // Navega para a tela de registro
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.black87, // Cor do texto do botão
        padding: const EdgeInsets.symmetric(vertical: 15), // Padding no botão
      ),
      child: const Text(
        'Criar uma conta', // Texto do botão
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
