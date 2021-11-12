import 'package:flutter/material.dart';
import 'package:json_api_example/controllers/app_controller.dart';
import 'package:json_api_example/models/comment.dart';

class CommentScreen extends StatefulWidget {
  final int postId;
  const CommentScreen({required this.postId, Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<Comment> commentDataList = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      var commentData = await AppContrloller.getComments(postId: widget.postId);
      setState(() {
        commentDataList = commentData;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comment Screen'),
        ),
        body: commentDataList.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: commentDataList.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                          title: Text(commentDataList[index].email.toString()),
                          subtitle: Text(
                            commentDataList[index].body.toString(),
                          )),
                    )));
  }
}
