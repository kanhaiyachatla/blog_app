import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:subspace_assignment/Home/bloc/home_bloc.dart';
import 'package:subspace_assignment/models/BlogModel.dart';

class BlogWidget extends StatelessWidget {
  final BlogModel blogModel;
  final HomeBloc homeBloc;
  const BlogWidget(
      {super.key, required this.blogModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('Favourites');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        child: Column(
          children: [
            Stack(children: [
              Image.network(
                blogModel.image_url,
                loadingBuilder: (context,child,progress) {
                  if(progress == null) {
                    return child;
                  }else{
                    return Container(
                      width: double.maxFinite,
                      height: 185,
                      color: Colors.grey.shade300,
                      child: Icon(Icons.image_outlined,size: 30,),
                    );
                  }
                },
                errorBuilder: (context, exception, stackTrace) {
                  return Container(
                      width: double.maxFinite,
                      height: 185,
                      color: Colors.grey.shade300,
                      child: Center(
                          child: Text(
                        'Network Error.. Please Try again',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )));
                },
                height: 185,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        shape: BoxShape.circle),
                    child: ValueListenableBuilder(
                      valueListenable: box.listenable(),
                      builder: (BuildContext context, value, Widget? child) {
                        return IconButton(
                          onPressed: () {
                            homeBloc.add(BlogFavClickedEvent(favModel: blogModel));
                          },
                          icon: (box.containsKey(blogModel.id))
                              ? Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          )
                              : Icon(
                            Icons.favorite_border,
                          ),
                        );
                      },
                    )),
              )
            ]),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
              child: Text(
                '${blogModel.title}',
                style: TextStyle(fontSize: 18,fontFamily: 'Playfair',fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
