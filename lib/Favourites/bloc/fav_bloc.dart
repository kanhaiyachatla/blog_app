import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../Home/bloc/home_bloc.dart';
import '../../models/BlogModel.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavBloc() : super(FavInitial()) {
    on<FavInitialEvent>(favInitialEvent);
    on<FavNavigateToBlogEvent>(favNavigateToBlogEvent);
    on<BlogFavRemoveActionEvent>(blogFavRemoveActionEvent);
  }

  

  FutureOr<void> favInitialEvent(FavInitialEvent event, Emitter<FavState> emit) {
    var Box = Hive.box('Favourites');
    List<Map<dynamic,dynamic>> favBlogs = [];
    Box.keys.forEach((key) {
      
      favBlogs.add(Box.get(key));
    });

    if(favBlogs.isEmpty){
      print('Empty');
      emit(FavEmptyState());
    }else{
      print('Not Empty');
      emit(FavSuccessState(favBlogs: favBlogs));
    }
  // emit(FavSuccessState(favBlogs: favBlogs));
  }


  Future<FutureOr<void>> blogFavRemoveActionEvent(BlogFavRemoveActionEvent event, Emitter<FavState> emit) async {
    var Box = Hive.box('Favourites');
    try {
      if (Box.containsKey(event.favID)) {
        await Box.delete(event.favID);
        emit(BlogFavRemoveActionState());
      }
    }catch (e){
      print('Error ${e.toString()}');
    }
  }

  FutureOr<void> favNavigateToBlogEvent(FavNavigateToBlogEvent event, Emitter<FavState> emit) {
    emit(FavNavigateToBlogActionState(blog: event.blog));
  }
}
