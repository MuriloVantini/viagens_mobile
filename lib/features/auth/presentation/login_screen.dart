import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viagens_mobile/features/auth/state/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final auth = context.read<AuthController>();
    await auth.login(username: _userController.text.trim(), password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Consumer<AuthController>(
              builder: (context, auth, _) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _userController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: 'Usuario'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Informe o usuario';
                          }
                          if (auth.error != null) {
                            return auth.error;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a senha';
                          }
                          if (auth.error != null) {
                            return auth.error;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      auth.isLoading ? const Center(child: CircularProgressIndicator()) : ElevatedButton(onPressed: auth.isLoading ? null : _submit, child: const Text('Entrar')),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
