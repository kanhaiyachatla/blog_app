import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../models/BlogModel.dart';


part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(BlogInitial()) {

  }

  Future<FutureOr<void>> blogFavClickedEvent(BlogFavClickEvent event, Emitter<BlogState> emit) async {

    var Box = Hive.box('Favourites');
    try {
      if(Box.containsKey(event.favModel.id)){
        await Box.delete(event.favModel.id);
        emit(BlogFavSuccessActionState());
      }else{
        await Box.put(event.favModel.id, event.favModel.toMap());
        emit(BlogFavSuccessActionState());
      }
    }catch (e){
      print('Error : ${e.toString()}');
    }
  }
}
