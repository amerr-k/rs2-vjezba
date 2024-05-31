// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:spsp_mobile/main.dart';
import 'package:spsp_mobile/screens/account/profile_settings_customer_screen.dart';
import 'package:spsp_mobile/screens/menu/menu_item_list_customer_screen.dart';
import 'package:spsp_mobile/screens/order/order_list_customer_screen.dart';
import 'package:spsp_mobile/screens/order/qr_code_scanner_customer_screen.dart';
import 'package:spsp_mobile/screens/reservation/reservation_list_customer_screen.dart';
import 'package:spsp_mobile/utils/util.dart';

class MasterScreenWidget extends StatefulWidget {
  String? title;
  Widget? titleWidget;
  Widget? child;
  MasterScreenWidget({this.title, this.child, this.titleWidget, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  int currentIndex = 0;

  void _onItemTapped(int index) async {
    setState(() {
      currentIndex = index;
    });
    if (currentIndex == 0) {
      Navigator.pushNamed(context, MenuItemListCustomerScreen.routeName);
    } else if (currentIndex == 1) {
      Navigator.pushNamed(context, OrderListCustomerScreen.routeName);
    } else if (currentIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRCodeScannerCustomerScreen(),
        ),
      );
    } else if (currentIndex == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReservationListCustomerScreen(),
        ),
      );
    } else if (currentIndex == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileSettingsCustomerScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: widget.titleWidget ?? Text(widget.title ?? "")),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Odjava"),
              onTap: () {
                Authorization.token = "";
                Authorization.username = "";
                Authorization.password = "";

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: widget.child!,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Meni',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Narudžbe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Skeniraj',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_bar),
            label: 'Rezervacije',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Postavke',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
