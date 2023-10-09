part of 'blog_bloc.dart';

@immutable
abstract class BlogState {}

abstract class BlogActionState extends BlogState {}

class BlogInitial extends BlogState {}

class BlogFavSuccessActionState extends BlogActionState{}
