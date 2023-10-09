part of 'fav_bloc.dart';

@immutable
abstract class FavEvent {}

class FavInitialEvent extends FavEvent{

}

class FavStartEvent extends FavEvent{}

class FavNavigateToBlogEvent extends FavEvent {
  final BlogModel blog;

  FavNavigateToBlogEvent({required this.blog});

}

class BlogFavRemoveActionEvent extends FavEvent{
  final String favID;

  BlogFavRemoveActionEvent({required this.favID});

}

