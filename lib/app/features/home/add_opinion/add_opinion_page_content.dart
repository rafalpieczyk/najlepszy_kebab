import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepszy_kebab/app/features/home/add_opinion/cubit/add_opinion_cubit.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    Key? key,
    required this.onSave,
  }) : super(key: key);
  final Function onSave;

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  var restaurantName = '';
  var kebsName = '';
  var rating = 3.0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOpinionCubit(),
      child: Builder(builder: (context) {
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
                Slider(
                  activeColor: const Color(0xFF459D87),
                  min: 1.0,
                  max: 5.0,
                  divisions: 8,
                  value: rating,
                  onChanged: (newValue) {
                    setState(() {
                      rating = newValue;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Icon(
                      Icons.star_outline,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF459D87),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(55)),
                    ),
                    onPressed: restaurantName.isEmpty || kebsName.isEmpty
                        ? null
                        : () {
                            context.read<AddOpinionCubit>().addOpinion(
                                  restaurantName: restaurantName,
                                  kebsName: kebsName,
                                  rating: rating,
                                );
                            widget.onSave();
                          },
                    child: const Icon(Icons.add),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
