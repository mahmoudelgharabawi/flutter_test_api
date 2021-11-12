import 'package:flutter/material.dart';
import 'package:json_api_example/controllers/app_controller.dart';
import 'package:json_api_example/models/post.dart';

class SendPost extends StatefulWidget {
  const SendPost({Key? key}) : super(key: key);

  @override
  _SendPostState createState() => _SendPostState();
}

class _SendPostState extends State<SendPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: titleController,
            decoration:
                InputDecoration(hintText: 'Enter title', labelText: 'Title'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'please Enter Title';
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            controller: bodyController,
            decoration:
                InputDecoration(hintText: 'Enter body', labelText: 'Body'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'please Enter Body';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Container()),
              Expanded(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
                child: Text('Send Post'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var newPost = Post(
                        userId: 2,
                        title: titleController.text,
                        body: bodyController.text);
                    await AppContrloller.createPost(body: newPost.toJson());
                  }
                },
              )),
              Expanded(child: Container()),
            ],
          )
        ],
      ),
    );
  }
}
