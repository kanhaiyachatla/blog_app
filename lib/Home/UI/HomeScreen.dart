import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subspace_assignment/Blog/UI/BlogScreen.dart';
import 'package:subspace_assignment/Home/UI/blog_widget.dart';
import 'package:subspace_assignment/Home/bloc/home_bloc.dart';
import 'package:http/http.dart' as http;

import '../../Favourites/UI/FavScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeBloc.add(HomeStartEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text('Blog Explorer',style: TextStyle(color: Colors.white,fontFamily: 'Playfair',fontWeight: FontWeight.w600),),
        actions: [
          IconButton(onPressed: () {
            homeBloc.add(HomeNavigateToFavEvent());
          }, icon: Icon(Icons.favorite),color: Colors.red,)
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(backgroundColor: Colors.black,onPressed: () {
          homeBloc.add(HomeStartEvent());
        },
          label: Text('Refresh',),
          icon: Icon(CupertinoIcons.refresh),
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigateToFavActionState) {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => FavScreen()));
          }else if (state is HomeNavigateToBlogActionState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlogScreen(
                          blog: state.blog,
                        )));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case HomeLoadedSuccessState:
              var successState = state as HomeLoadedSuccessState;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                      child: Text('Latest Blogs',style: TextStyle(fontSize: 22,color: Colors.black,fontFamily: 'Playfair'),),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  homeBloc.add(HomeNavigateToBlogEvent(blog: successState.blogs[index]));
                                },
                                child: BlogWidget(
                                  blogModel: successState.blogs[index],
                                  homeBloc: homeBloc,
                                ),
                              );
                            },
                            itemCount: successState.blogs.length,
                          ),
                  ],
                ),
              );
            case HomeErrorState:
              return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.report_gmailerrorred_outlined,size: 80,color: Colors.red,),
                          SizedBox(height: 30,),
                          Text("Something went Wrong.. try Again Later.\n You can we your favourite Blogs offline",style: TextStyle(fontFamily: 'Playfair',fontSize: 16),),
                        ],
                      ),
                    );
            default:
              return Container();
          }
          return Center(
            child: Text('Hello world'),
          );
        },
      ),
    );
  }
}
