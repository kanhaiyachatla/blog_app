part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent {}

class BlogFavClickEvent extends BlogEvent {
  final BlogModel favModel;
  BlogFavClickEvent({
    required this.favModel,
  });
}
