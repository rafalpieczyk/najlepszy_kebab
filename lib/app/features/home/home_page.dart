import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:najlepszy_kebab/app/features/home/add_opinion/add_opinion_page_content.dart';
import 'package:najlepszy_kebab/app/features/home/my_account/my_account_page_content.dart';
import 'package:najlepszy_kebab/app/features/home/restaurants/restaurant_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB6BEC9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF459D87),
        toolbarHeight: 50,
        title: const Text('Najlepszy Kebab na Śląsku'),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const RestaurantPageContent();
        }
        if (currentIndex == 1) {
          return AddOpinionPageContent(onSave: () {
            setState(() {
              currentIndex = 0;
            });
          });
        }

        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFB6BEC9),
          selectedItemColor: const Color(0xFF459D87),
          currentIndex: currentIndex,
          onTap: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star,
                ),
                label: 'Opinie'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                ),
                label: 'Dodaj'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Moje konto'),
          ]),
    );
  }
}
