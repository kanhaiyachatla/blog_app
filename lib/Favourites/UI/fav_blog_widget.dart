import 'package:flutter/material.dart';
import 'package:subspace_assignment/Favourites/bloc/fav_bloc.dart';
import 'package:subspace_assignment/models/BlogModel.dart';

class FavBlogWidget extends StatelessWidget {
  final Map<dynamic,dynamic> favBlog;
  final FavBloc favBloc;
  const FavBlogWidget({super.key, required this.favBlog,required this.favBloc});

  @override
  Widget build(BuildContext context) {
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
                favBlog['image_url'],
                errorBuilder: (context,exception,stackTrace) {
                  return Container(
                      width:double.maxFinite,
                      height: 185,
                      color: Colors.grey.shade500,
                      child: Center(child: Text('Network Error.. Please Try again',style: TextStyle(backgroundColor: Colors.white,color: Colors.red,fontWeight: FontWeight.w600),)));
                },
                // loadingBuilder: (context, child, loadingProgress) {
                //   if (loadingProgress == null) {
                //     return child;
                //   }
                //   return Container(
                //     width: double.maxFinite,
                //     color: Colors.grey.shade300,
                //     height: 185,
                //     child: Center(
                //       child: CircularProgressIndicator(
                //         value: loadingProgress.expectedTotalBytes != null
                //             ? loadingProgress.cumulativeBytesLoaded /
                //             loadingProgress.expectedTotalBytes!
                //             : null,
                //       ),
                //     ),
                //   );
                // },
                height: 185,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () {
                        favBloc.add(BlogFavRemoveActionEvent(favID: favBlog['id']));
                      },
                      icon: Icon(Icons.favorite,color: Colors.redAccent,),
                    )
                ),
              )
            ]),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
              child: Text(
                '${favBlog['title']}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
