part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}


class HomeLoadingState extends HomeState{
}

class HomeLoadedSuccessState extends HomeState{
  final List blogs;

  HomeLoadedSuccessState({required this.blogs});
}

class HomeErrorState extends HomeState{}

class HomeNavigateToBlogActionState extends HomeActionState {
  final BlogModel blog;

  HomeNavigateToBlogActionState({required this.blog});

}

class HomeNavigateToFavActionState extends HomeActionState{}

class BlogFavSuccessActionState extends HomeActionState{}
