import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:spsp_mobile/models/pdf/customer_pdf.dart';
import 'package:spsp_mobile/providers/auth_provider.dart';
import 'package:spsp_mobile/providers/promotion_provider.dart';
import 'package:spsp_mobile/providers/qr_table_selector_provider.dart';
import 'package:spsp_mobile/providers/category_provider.dart';
import 'package:spsp_mobile/providers/customer_provider.dart';
import 'package:spsp_mobile/providers/menu_item_provider.dart';
import 'package:spsp_mobile/providers/menu_provider.dart';
import 'package:spsp_mobile/providers/order_provider.dart';
import 'package:spsp_mobile/providers/prediction_menu_item_provider.dart';
import 'package:spsp_mobile/providers/qr_table_provider.dart';
import 'package:spsp_mobile/providers/reservation_provider.dart';
import 'package:spsp_mobile/providers/sale_invoice_provider.dart';
import 'package:spsp_mobile/providers/transaction_provider.dart';
import 'package:spsp_mobile/providers/user_provider.dart';
import 'package:spsp_mobile/screens/menu/menu_item_details_customer_screen.dart';
import 'package:spsp_mobile/screens/menu/menu_item_list_customer_screen.dart';
import 'package:spsp_mobile/screens/order/order_list_customer_screen.dart';
import 'package:spsp_mobile/screens/account/registration_form_screen.dart';
import 'package:spsp_mobile/screens/reservation/reservation_details_customer_screen.dart';
import 'package:spsp_mobile/screens/reservation/reservation_list_customer_screen.dart';
import 'package:spsp_mobile/utils/util.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => MenuItemProvider()),
      ChangeNotifierProvider(create: (_) => MenuProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => QRTableSelectorProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ChangeNotifierProvider(create: (_) => SaleInvoiceProvider()),
      ChangeNotifierProvider(create: (_) => MenuItemPredictionProvider()),
      ChangeNotifierProvider(create: (_) => ReservationProvider()),
      ChangeNotifierProvider(create: (_) => QRTableProvider()),
      ChangeNotifierProvider(create: (_) => CustomerProvider()),
      ChangeNotifierProvider(create: (_) => PromotionProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple,
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: Colors.deepPurple,
                textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic))),
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      home: HomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == MenuItemListCustomerScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => MenuItemListCustomerScreen()));
        }
        if (settings.name == RegistrationScreenScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => RegistrationScreenScreen()));
        }
        if (settings.name == OrderListCustomerScreen.routeName) {
          return MaterialPageRoute(builder: ((context) => OrderListCustomerScreen()));
        }
        if (settings.name == ReservationListCustomerScreen.routeName) {
          return MaterialPageRoute(
              builder: ((context) => ReservationListCustomerScreen()));
        }

        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 &&
            "/${uri.pathSegments.first}" == MenuItemDetailsCustomerScreen.routeName) {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(
              builder: (context) => MenuItemDetailsCustomerScreen(
                    id: id,
                  ));
        }

        if (uri.pathSegments.length == 2 &&
            "/${uri.pathSegments.first}" == ReservationDetailsCustomerScreen.routeName) {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (context) => ReservationDetailsCustomerScreen(
              id: id,
            ),
          );
        }
      },
    ),
  ));
}

class HomePage extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late UserProvider _userProvider;
  late AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.jpg"),
                      fit: BoxFit.fill)),
              child: Stack(children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(155, 226, 227, 240),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        "SKENIRAJ I PLATI!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 18, 0, 85),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Pasword",
                          hintStyle: TextStyle(color: Colors.grey[400])),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6)
                ]),
              ),
              child: InkWell(
                onTap: () async {
                  try {
                    Authorization.username = _usernameController.text;
                    Authorization.password = _passwordController.text;

                    await _authProvider.login();

                    Navigator.pushNamed(context, MenuItemListCustomerScreen.routeName);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Center(child: Text("Prijava")),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RegistrationScreenScreen.routeName);
              },
              child: const Text(
                'Kreirajte novi račun.',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
