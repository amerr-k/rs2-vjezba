import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spsp_mobile/models/menu_item.dart';
import 'package:spsp_mobile/models/promotion.dart';
import 'package:spsp_mobile/models/search_result.dart';
import 'package:spsp_mobile/providers/menu_item_provider.dart';
import 'package:spsp_mobile/providers/promotion_provider.dart';
import 'package:spsp_mobile/screens/menu/menu_item_details_customer_screen.dart';
import 'package:spsp_mobile/utils/util.dart';
import 'package:spsp_mobile/widgets/master_screen.dart';

class MenuItemListCustomerScreen extends StatefulWidget {
  static const String routeName = "/menu-item";

  const MenuItemListCustomerScreen({super.key});

  @override
  State<MenuItemListCustomerScreen> createState() => _MenuItemListCustomerScreenState();
}

class _MenuItemListCustomerScreenState extends State<MenuItemListCustomerScreen> {
  RequestResult<MenuItem>? menuItems;
  RequestResult<Promotion>? promotions;
  late MenuItemProvider _menuItemProvider;
  late PromotionProvider _promotionProvider;
  final TextEditingController _ftsController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _menuItemProvider = context.read<MenuItemProvider>();
    _promotionProvider = context.read<PromotionProvider>();

    _loadData();
  }

  _loadData() async {
    var menuItemsGetSearchResult = await _menuItemProvider.get();
    var promotionGetSearchResult = await _promotionProvider.get(filter: {
      'IsOnlyTodaysIncluded': true,
    });
    setState(() {
      menuItems = menuItemsGetSearchResult;
      promotions = promotionGetSearchResult;
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _menuItemProvider = context.read<MenuItemProvider>();
    var menuItemsGetSearchResult = await _menuItemProvider.get();
    setState(() {
      menuItems = menuItemsGetSearchResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSearch(),
          isLoading ? Container() : _buildDismissiblePromotion(),
          Expanded(
              child: isLoading
                  ? Container(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : _buildMenuItemCardList()),
        ],
      ),
    );
  }

  // Widget _buildDismissiblePromotion() {
  //   return Dismissible(
  //     key: UniqueKey(),
  //     background: Container(
  //       color: Colors.red,
  //       child: Icon(Icons.delete),
  //     ),
  //     child: _buildPromotionCardList(),
  //   );
  // }

  Widget _buildDismissiblePromotion() {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete),
      ),
      child: Column(
        children: [
          Text("Uklonite promociju prevlačenjem prsta na stranu."),
          _buildPromotionCardList(),
        ],
      ),
    );
  }

  Widget _buildPromotionCardList() {
    return Container(
      child: Column(
        children: List.generate(promotions?.count ?? 0, (index) {
          return _buildPromotionCard(promotions!.result[index]);
        }),
      ),
    );
  }

  Widget _buildPromotionCard(Promotion item) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF170),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: ListTile(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MenuItemDetailsCustomerScreen(id: item.menuItem!.id!.toString()),
                ),
              )
            },
            subtitle: Text(
              item.menuItem!.name!,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(item.description),
            trailing: imageFromBase64String(item!.menuItem!.image!),
          )),
    );
  }

  Widget _buildMenuItemCardList() {
    return Container(
      child: ListView.builder(
        itemCount: menuItems?.count,
        itemBuilder: (context, index) {
          return _buildMenuItemCard(menuItems!.result[index]);
        },
      ),
    );
  }

  Widget _buildMenuItemCard(MenuItem item) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
            context, "${MenuItemDetailsCustomerScreen.routeName}/${item.id}");
      },
      leading: imageFromBase64String(item!.image!),
      title: Text(item.name ?? ""),
      subtitle: Text('${formatNumber(item.price!)} KM'),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Unesite traženi proizvod...",
              ),
              controller: _ftsController,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              var data = await _menuItemProvider.get(filter: {
                'fts': _ftsController.text,
                'name': _nameController.text,
              });
              setState(() {
                menuItems = data;
                isLoading = false;
              });
            },
            child: const Text("Traži"),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
