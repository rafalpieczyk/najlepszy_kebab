part of 'restaurants_cubit.dart';

@immutable
class RestaurantsState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;

  const RestaurantsState({required this.documents});
}
