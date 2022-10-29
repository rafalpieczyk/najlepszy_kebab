// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_opinion_state.dart';

class AddOpinionCubit extends Cubit<AddOpinionState> {
  AddOpinionCubit() : super(AddOpinionState());

  Future<void> addOpinion({
    required restaurantName,
    required kebsName,
    required rating,
  }) async {
    FirebaseFirestore.instance.collection('restaurants').add({
      'name': restaurantName,
      'kebs': kebsName,
      'rating': rating,
    });
  }
}
