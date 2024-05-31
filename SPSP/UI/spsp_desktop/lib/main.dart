// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spsp_desktop/providers/cart_provider.dart';
import 'package:spsp_desktop/providers/category_provider.dart';
import 'package:spsp_desktop/providers/menu_item_provider.dart';
import 'package:spsp_desktop/providers/menu_provider.dart';
import 'package:spsp_desktop/providers/order_provider.dart';
import 'package:spsp_desktop/providers/promotion_provider.dart';
import 'package:spsp_desktop/providers/qr_table_provider.dart';
import 'package:spsp_desktop/providers/report_provider.dart';
import 'package:spsp_desktop/utils/util.dart';
import 'screens/menu/menu_item_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuItemProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => QRTableProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => PromotionProvider()),
      ],
      child: const MyMaterialApp(),
    ),
  );
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Skeniraj - plati",
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
        home: LoginPage());
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late MenuItemProvider _menuItemProvider;

  @override
  Widget build(BuildContext context) {
    _menuItemProvider = context.read<MenuItemProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Prijava")),
      body: Center(
        child: Container(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildLogo(),
                    _buildUsernameTextField(_usernameController),
                    const SizedBox(height: 8),
                    _buildPasswordField(_passwordController),
                    const SizedBox(height: 8),
                    _buildLoginButton(context, _usernameController, _passwordController,
                        _menuItemProvider)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

Widget _buildLogo() {
  return Image.asset("assets/images/logo.png", height: 130, width: 130);
}

Widget _buildUsernameTextField(TextEditingController usernameController) {
  return TextField(
    decoration:
        const InputDecoration(labelText: "Korisničko ime", prefixIcon: Icon(Icons.email)),
    controller: usernameController,
  );
}

Widget _buildPasswordField(TextEditingController passwordController) {
  return TextField(
    obscureText: true,
    enableSuggestions: false,
    autocorrect: false,
    decoration:
        const InputDecoration(labelText: "Lozinka", prefixIcon: Icon(Icons.password)),
    controller: passwordController,
  );
}

Widget _buildLoginButton(BuildContext context, TextEditingController usernameController,
    TextEditingController passwordController, MenuItemProvider menuItemProvider) {
  return ElevatedButton(
      onPressed: () async {
        var username = usernameController.text;
        var password = passwordController.text;

        Authorization.username = username;
        Authorization.password = password;

        try {
          await menuItemProvider.get();

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MenuItemListScreen(),
            ),
          );
        } on Exception catch (e) {
          showDialog(
            context: context,
            builder: ((BuildContext context) => AlertDialog(
                  title: Text("Error"),
                  content: Text(
                    e.toString(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Uredu"),
                    ),
                  ],
                )),
          );
        }
      },
      child: const Text("Prijava"));
}
