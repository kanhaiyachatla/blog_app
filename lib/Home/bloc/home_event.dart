part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeStartEvent extends HomeEvent {}

class HomeNavigateToFavEvent extends HomeEvent {}

class HomeNavigateToBlogEvent extends HomeEvent {
  final BlogModel blog;

  HomeNavigateToBlogEvent({required this.blog});

}

class BLogClickedEvent extends HomeEvent {
  final BlogModel blogModel;
  BLogClickedEvent({required this.blogModel});

}

class BlogFavClickedEvent extends HomeEvent {
  final BlogModel favModel;
  BlogFavClickedEvent({
    required this.favModel,
  });
}
