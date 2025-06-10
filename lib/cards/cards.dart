import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(1, 87, 155, 1); // لون أزرق غامق
const secondaryColor = Color.fromRGBO(187, 222, 251, 1); // لون أزرق فاتح
const borderColor = Color.fromRGBO(100, 181, 246, 1); // لون حدود الكرت

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget targetPage;

  const CustomCard(this.icon, this.title, this.targetPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        color: secondaryColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: primaryColor),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Go To Page', style: TextStyle(fontSize: 16)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => targetPage),
              );
            },
          ),
        ],
      ),
    );
  }
}
