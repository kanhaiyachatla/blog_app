import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart'as http;
import 'package:subspace_assignment/Blog/bloc/blog_bloc.dart';

import '../../models/BlogModel.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeStartEvent>(homeStartEvent);
    on<HomeNavigateToFavEvent>(homeNavigateToFavEvent);
    on<BlogFavClickedEvent>(blogFavClickedEvent);
    on<HomeNavigateToBlogEvent>(homeNavigateToBlogEvent);
  }

  FutureOr<void> homeNavigateToFavEvent(HomeNavigateToFavEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToFavActionState());
  }

  Future<FutureOr<void>> blogFavClickedEvent(BlogFavClickedEvent event, Emitter<HomeState> emit) async {

    var Box = Hive.box('Favourites');
    try {
      if(Box.containsKey(event.favModel.id)){
        await Box.delete(event.favModel.id);
        emit(BlogFavSuccessActionState());
      }else{
        await Box.put(event.favModel.id, event.favModel.toMap());
        emit(BlogFavSuccessActionState());
      }
    }catch (e) {
    }
  }

  Future<FutureOr<void>> homeStartEvent(HomeStartEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';


    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {

        List templist =  jsonDecode(response.body)['blogs'].toList();
        List blog = templist.map((e) => BlogModel.fromJson(e)).toList();
        emit(HomeLoadedSuccessState(blogs:blog,),);
      } else {
        emit(HomeErrorState());
      }
    } catch (e) {
      emit(HomeErrorState());
    }

  }

  FutureOr<void> homeNavigateToBlogEvent(HomeNavigateToBlogEvent event, Emitter<HomeState> emit) {

    emit(HomeNavigateToBlogActionState(blog: event.blog));
  }
}
