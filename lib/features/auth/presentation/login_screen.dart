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
    final auth = context.read<AuthController>();
    auth.clearError();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final success = await auth.login(username: _userController.text.trim(), password: _passwordController.text);

    if (!success && mounted) {
      setState(() {});
    }
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
                    spacing: 16,
                    children: [
                      SizedBox(height: 120, child: Image.asset('assets/images/agt_logo.png', fit: BoxFit.contain)),
                      const SizedBox(height: 16),
                      Text(
                        'App de Viagens',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.primary, shadows: [
                          Shadow(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                            offset: const Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ]),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _userController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(prefixIcon: const Icon(Icons.person), labelText: 'Usuário', errorText: auth.error),
                        onChanged: (_) => context.read<AuthController>().clearError(),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Informe o usuario';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(prefixIcon: const Icon(Icons.lock), labelText: 'Senha', errorText: auth.error),
                        onChanged: (_) => context.read<AuthController>().clearError(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a senha';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      auth.isLoading ? const Center(child: CircularProgressIndicator()) : OutlinedButton(onPressed: _submit, child: const Text('Entrar')),
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
