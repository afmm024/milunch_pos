import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:customizable_counter/customizable_counter.dart';

class FacturaScreen extends StatelessWidget {
  /// Constructs a [FacturaScreen]
  const FacturaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 14,
            child: Column(
              children: [
                Container(
                  height: 100,
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _itemTab(
                        icon: 'icons/icon-burger.png',
                        title: 'Burger',
                        isActive: true,
                      ),
                      _itemTab(
                        icon: 'icons/icon-noodles.png',
                        title: 'Noodles',
                        isActive: false,
                      ),
                      _itemTab(
                        icon: 'icons/icon-drinks.png',
                        title: 'Drinks',
                        isActive: false,
                      ),
                      _itemTab(
                        icon: 'icons/icon-desserts.png',
                        title: 'Desserts',
                        isActive: false,
                      ),
                      _itemTab(
                        icon: 'icons/icon-burger.png',
                        title: 'Burger',
                        isActive: true,
                      ),
                      _itemTab(
                        icon: 'icons/icon-noodles.png',
                        title: 'Noodles',
                        isActive: false,
                      ),
                      _itemTab(
                        icon: 'icons/icon-drinks.png',
                        title: 'Drinks',
                        isActive: false,
                      ),
                      _itemTab(
                        icon: 'icons/icon-desserts.png',
                        title: 'Desserts',
                        isActive: false,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 4,
                    childAspectRatio: (1 / 1.2),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    children: [
                      _item(
                        image: 'items/1.png',
                        title: 'Original Burger',
                        price: '\$5.99',
                        item: '11 item',
                      ),
                      _item(
                        image: 'items/2.png',
                        title: 'Double Burger',
                        price: '\$10.99',
                        item: '10 item',
                      ),
                      _item(
                        image: 'items/3.png',
                        title: 'Cheese Burger',
                        price: '\$6.99',
                        item: '7 item',
                      ),
                      _item(
                        image: 'items/4.png',
                        title: 'Double Cheese Burger',
                        price: '\$12.99',
                        item: '20 item',
                      ),
                      _item(
                        image: 'items/5.png',
                        title: 'Spicy Burger',
                        price: '\$7.39',
                        item: '12 item',
                      ),
                      _item(
                        image: 'items/6.png',
                        title: 'Special Black Burger',
                        price: '\$7.39',
                        item: '39 item',
                      ),
                      _item(
                        image: 'items/7.png',
                        title: 'Special Cheese Burger',
                        price: '\$8.00',
                        item: '2 item',
                      ),
                      _item(
                        image: 'items/8.png',
                        title: 'Jumbo Cheese Burger',
                        price: '\$15.99',
                        item: '2 item',
                      ),
                      _item(
                        image: 'items/9.png',
                        title: 'Spicy Burger',
                        price: '\$7.39',
                        item: '12 item',
                      ),
                      _item(
                        image: 'items/10.png',
                        title: 'Special Black Burger',
                        price: '\$7.39',
                        item: '39 item',
                      ),
                      _item(
                        image: 'items/11.png',
                        title: 'Special Cheese Burger',
                        price: '\$8.00',
                        item: '2 item',
                      ),
                      _item(
                        image: 'items/12.png',
                        title: 'Jumbo Cheese Burger',
                        price: '\$15.99',
                        item: '2 item',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200, width: 3),
                ),
                child: Column(
                  children: [
                    _topMenu(
                      title: 'Orden',
                      subTitle: 'Nombre de usuario',
                      action: SizedBox(),
                    ),
                    const SizedBox(height: 20),
                    BarcodeKeyboardListener(
                        child: SizedBox(),
                        onBarcodeScanned: (barcode) {
                          debugPrint(barcode);
                        }),
                    Expanded(
                      child: ListView(
                        children: [
                          _itemOrder(
                            image: 'items/1.png',
                            title: 'Orginal Burger',
                            qty: '2',
                            price: '\$5.99',
                          ),
                          _itemOrder(
                            image: 'items/2.png',
                            title: 'Double Burger',
                            qty: '3',
                            price: '\$10.99',
                          ),
                          _itemOrder(
                            image: 'items/6.png',
                            title: 'Special Black Burger',
                            qty: '2',
                            price: '\$8.00',
                          ),
                          _itemOrder(
                            image: 'items/4.png',
                            title: 'Special Cheese Burger',
                            qty: '2',
                            price: '\$12.99',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.red,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Sub Total',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '\$40.32',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Descuento',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '\$4.32',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              height: 2,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  '\$44.64',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.red,
                                primary: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.print, size: 16),
                                  SizedBox(width: 6),
                                  Text('Facturar')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _itemOrder({
    required String image,
    required String title,
    required String qty,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage('assets/' + image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          CustomizableCounter(
            borderColor: Colors.red,
            borderWidth: 1,
            borderRadius: 10,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            textSize: 15,
            showButtonText: false,
            count: 1,
            step: 1,
            minCount: 1,
            maxCount: 10,
            incrementIcon: const Icon(
              Icons.add,
              color: Colors.black,
              size: 15,
            ),
            decrementIcon: const Icon(
              Icons.remove,
              color: Colors.black,
              size: 15,
            ),
            onDecrement: (value) {},
            onIncrement: (value) {},
            onCountChange: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String image,
    required String title,
    required String price,
    required String item,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage('assets/' + image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: item),
                    const WidgetSpan(
                        child:
                            Icon(Icons.check, size: 18, color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8.0,
            children: <Widget>[
              OutlinedButton(onPressed: () {}, child: Text('Express')),
              ElevatedButton(onPressed: () {}, child: Text('Carrito'))
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemTab(
      {required String icon, required String title, required bool isActive}) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 26),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: isActive
            ? Border.all(color: Colors.red, width: 3)
            : Border.all(color: Colors.grey.shade200, width: 3),
      ),
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/' + icon),
            width: 38,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _topMenu({
    required String title,
    required String subTitle,
    required Widget action,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subTitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ],
        ),
        Expanded(flex: 1, child: Container(width: double.infinity)),
        Expanded(flex: 5, child: action),
      ],
    );
  }
}
