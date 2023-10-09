part of 'fav_bloc.dart';

@immutable
abstract class FavState {}

abstract class FavActionState extends FavState{
}

class FavInitial extends FavState {}

class FavNavigateToBlogActionState extends FavActionState {
  final BlogModel blog;

  FavNavigateToBlogActionState({required this.blog});

}

class FavLoadingState extends FavState{}

class FavLoadedSuccessState extends FavState{
}

class FavErrorState extends FavState{}


class BlogFavRemoveActionState extends FavActionState{
}

class FavEmptyState extends FavState {}

class FavSuccessState extends FavState{
  final List favBlogs;
  FavSuccessState({required this.favBlogs});
}
