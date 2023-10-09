import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:subspace_assignment/Blog/UI/BlogScreen.dart';
import 'package:subspace_assignment/Favourites/bloc/fav_bloc.dart';
import 'package:subspace_assignment/Home/bloc/home_bloc.dart';
import 'package:subspace_assignment/models/BlogModel.dart';
import 'fav_blog_widget.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  final FavBloc favBloc = FavBloc();
  Box box = Hive.box('Favourites');

  @override
  void initState() {
    favBloc.add(FavInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text('Favorites',style: TextStyle(fontFamily: 'Playfair'),),
      ),
      body: BlocConsumer<FavBloc, FavState>(
        bloc: favBloc,
        listener: (context, state) {
          if (state is BlogFavRemoveActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Removed From Favourites')));
            Navigator.pop(context);
          } else if (state is FavNavigateToBlogActionState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlogScreen(blog: state.blog)));
          }
        },
        listenWhen: (previous, current) => current is FavActionState,
        buildWhen: (previous, current) => current is! FavActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case FavEmptyState:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite,color: Colors.redAccent,size: 80,),
                    SizedBox(height: 30,),
                    Text('Like Your Favourite Blogs and access them Offline ',style: TextStyle(fontFamily: "Playfair",fontSize: 16),textAlign: TextAlign.center,),
                  ],
                ),
              );
            case FavSuccessState:
              final successState = state as FavSuccessState;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      favBloc.add(FavNavigateToBlogEvent(
                          blog: BlogModel.fromJson(successState.favBlogs[index])));
                    },
                    child: FavBlogWidget(
                      favBlog: successState.favBlogs[index],
                      favBloc: favBloc,
                    ),
                  );
                },
                itemCount: successState.favBlogs.length,
              );
            default:
              List favBlogs = [];
              box.keys.forEach((element) {
                favBlogs.add(box.get(element));
              });
              if(favBlogs.isEmpty){
                return Text('Your Liked Blogs will be saved here Offline');
              }else{
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        favBloc.add(FavNavigateToBlogEvent(blog: BlogModel.fromJson(favBlogs[index])));
                      },
                      child: FavBlogWidget(
                          favBlog: favBlogs[index], favBloc: favBloc),
                    );
                  },
                  itemCount: favBlogs.length,
                );
              }

          }
        },
      ),
    );
  }
}
