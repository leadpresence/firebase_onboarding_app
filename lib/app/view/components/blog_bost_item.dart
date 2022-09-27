import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/blog_post.dart';
import '../home/blog_datail_view.dart';
import 'custom_l_button.dart';

class BlogPostWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const BlogPostWidget({
    required Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogData = data;
    return
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: <Widget>[
          Container(
              height: 160,
              width: screenWidth(context),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: -7,
                      offset: Offset(0, 10),
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 25,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(4))),
          GestureDetector(
            onTap: () => Get.to(() => BlogDetailView(
                  key: key,
                  post: blogData,
                )),
            child: Container(
              height: 170,
              width: screenWidth(context),
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(blogData['imageLink'])),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      onTap: () {
                        Get.to(() => BlogDetailView(
                              key: key,
                              post: blogData,
                            ));
                      },
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          blogData['title'] ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10),
                          Text(
                            blogData['category'] ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.purpleAccent,
                                fontWeight: FontWeight.w400,
                                fontSize: 11),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            blogData['title'] ?? "",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                height: 1.4,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w300,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
