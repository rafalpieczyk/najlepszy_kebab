import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  var restaurantName = '';
  var kebsName = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Nazwa restauracji',
              ),
              onChanged: (newValue) {
                setState(() {
                  restaurantName = newValue;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Rodzaj kebsa',
              ),
              onChanged: (newValue) {
                setState(() {
                  kebsName = newValue;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(55)),
                ),
                onPressed: () {
                  FirebaseFirestore.instance.collection('restaurants').add({
                    'name': restaurantName,
                    'kebs': kebsName,
                    'rating': 3.0,
                  });
                },
                child: const Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
