import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController userController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final AuthService authService =
      AuthService();

  void login() {

    final user = userController.text;
    final password =
        passwordController.text;

    if (user.isEmpty || password.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'Preencha todos os campos',
          ),
        ),
      );

      return;
    }

    if (password.length < 6) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'A senha deve ter no mínimo 6 caracteres',
          ),
        ),
      );

      return;
    }

    final success =
        authService.login(user, password);

    if (success) {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) =>
              const HomePage(),
        ),
      );

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'Usuário ou senha inválidos',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(25),

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              Container(

                padding:
                    const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  color: const Color(
                    0xFF800020,
                  ),

                  borderRadius:
                      BorderRadius.circular(25),
                ),

                child: const Icon(

                  Icons.movie_creation_outlined,

                  color: Colors.white,

                  size: 80,
                ),
              ),

              const SizedBox(height: 30),

              const Text(

                'CineVerse',

                style: TextStyle(

                  fontSize: 36,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(

                'Seu catálogo de filmes',

                style: TextStyle(

                  fontSize: 18,

                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 40),

              TextField(

                controller: userController,

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration:
                    const InputDecoration(

                  labelText: 'Usuário',

                  prefixIcon:
                      Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 20),

              TextField(

                controller:
                    passwordController,

                obscureText: true,

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration:
                    const InputDecoration(

                  labelText: 'Senha',

                  prefixIcon:
                      Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: login,

                  child: const Text(

                    'ENTRAR',

                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(

                'Explore o universo do cinema',

                style: TextStyle(

                  color: Colors.white54,

                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}