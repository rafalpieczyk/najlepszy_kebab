import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepszy_kebab/app/cubit/root_cubit.dart';

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
          Text(
            'Jesteś zalogowany jako $email',
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF459D87)),
            onPressed: () {
              context.read<RootCubit>().signOut();
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
