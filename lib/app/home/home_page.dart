import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text('Najlepszy Kebab na Śląsku'),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const RestaurantPageContent();
        }
        if (currentIndex == 1) {
          return const AddOpinionPageContent();
        }

        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
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

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Jesteś zalogowany jako $email'),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text(
              'Wyloguj',
            ),
          ),
        ],
      ),
    );
  }
}

class AddOpinionPageContent extends StatelessWidget {
  const AddOpinionPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('dodaj'),
    );
  }
}

class RestaurantPageContent extends StatelessWidget {
  const RestaurantPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('restaurants').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Waiting for data'));
          }
          final documents = snapshot.data!.docs;
          return ListView(
            children: [
              for (final document in documents) ...[
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              document['name'],
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              document['kebs'],
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          document['rating'].toString(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        });
  }
}
