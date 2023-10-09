import 'package:flutter/material.dart';
import 'package:subspace_assignment/Blog/bloc/blog_bloc.dart';

import '../../models/BlogModel.dart';

class BlogScreen extends StatefulWidget {
  final BlogModel blog;
  const BlogScreen({required this.blog,super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState(this.blog);
}

class _BlogScreenState extends State<BlogScreen> {
  final BlogModel blogModel;

  _BlogScreenState(this.blogModel);

  @override
  Widget build(BuildContext context) {
    final BlogBloc blogBloc = BlogBloc();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text('Blog',style: TextStyle(fontFamily: 'Playfair'),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(blogModel.image_url,width: double.maxFinite,height: 200,errorBuilder: (context,exception,stackTrace) {
              return Container(
                  width:double.maxFinite,
                  height: 185,
                  color: Colors.grey.shade500,
                  child: Center(child: Text('Network Error.. Please Try again',style: TextStyle(backgroundColor: Colors.white,color: Colors.red,fontWeight: FontWeight.w600),)));
            },loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Container(
                width: double.maxFinite,
                color: Colors.grey.shade300,
                height: 185,
                child: Center(
                  child: Icon(Icons.image_outlined,size: 30,),
                ),
              );
            }),
            SizedBox(height: 8,),
            Text('${blogModel.title}',style: TextStyle(fontSize: 20,fontFamily: 'Playfair',fontWeight: FontWeight.w600),),
            SizedBox(height: 8,),
            Text('ID : ${blogModel.id}',style: TextStyle(fontSize: 14),),
            Divider(thickness: 2,),
          ],
        ),
      ),

    );
  }
}
