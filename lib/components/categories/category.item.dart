import 'package:flutter/material.dart';

class CardHorizontalItem extends StatelessWidget {

  final String icon;
  final String title;
  final bool isActive;

  CardHorizontalItem({
    required this.icon, 
    required this.title, 
    required this.isActive
  });

  @override
  Widget build(BuildContext context){
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
  
}