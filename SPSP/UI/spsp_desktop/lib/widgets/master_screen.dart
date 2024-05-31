// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:spsp_desktop/main.dart';
import 'package:spsp_desktop/screens/menu/menu_item_list_screen.dart';
import 'package:spsp_desktop/screens/order/order_list_screen.dart';
import 'package:spsp_desktop/screens/pos/pos_screen.dart';
import 'package:spsp_desktop/screens/promotion/promotion_list_screen.dart';
import 'package:spsp_desktop/screens/report/report_form_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  String? title;
  Widget? titleWidget;
  Widget? child;
  MasterScreenWidget({this.title, this.child, this.titleWidget, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            ListTile(
              title: Text("Proizvodi"),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MenuItemListScreen()));
              },
            ),
            ListTile(
              title: Text("POS"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => POSScreen()));
              },
            ),
            ListTile(
              title: Text("Narudžbe"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => OrderListScreen()));
              },
            ),
            ListTile(
              title: Text("Izvještaji"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ReportFormScreen()));
              },
            ),
            ListTile(
              title: Text("Promocije"),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => PromotionListScreen()));
              },
            )
          ],
        ),
      ),
      body: widget.child!,
    );
  }
}
