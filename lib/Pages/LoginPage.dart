import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/PrimaryButton.dart';
import 'package:get/get.dart';
import '../../Controller/AuthController.dart';
import 'RegistrationPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  String selectedRole = 'user';

  void loginUser() {
    authController.loginWithEmail(
      emailController.text.trim(),
      passwordController.text.trim(),
      selectedRole,
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Image.asset("Assets/Images/book.png", height: 120),
              const SizedBox(height: 20),
              Text("Welcome Back!", style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Log in to continue reading", style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
              const SizedBox(height: 30),

              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedRole,
                items: const [
                  DropdownMenuItem(value: 'user', child: Text('User')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (value) => setState(() => selectedRole = value!),
                decoration: InputDecoration(
                  labelText: "Select Role",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 30),

              Obx(() => authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : PrimaryButton(
                btnName: "LOGIN",
                onTap: loginUser,
                showGoogleIcon: false,
              )),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () => Get.to(() => const RegistrationPage()),
                child: const Text("Don't have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
