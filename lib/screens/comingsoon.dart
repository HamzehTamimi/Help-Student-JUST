import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coming Soon!'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(187, 222, 251, 1),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 250, color: Colors.amber),
            Text(
              "This page is still under construction!",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {Navigator.pop(context);},
              child: Text("Go to Home"),
              style: TextButton.styleFrom(
                backgroundColor: Color.fromRGBO(1, 87, 155, 1),
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(25)
              ),
            )
          ],
        ),
      ),
    );
  }
}
