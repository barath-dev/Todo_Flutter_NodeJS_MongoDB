import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todo/components/text_field.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/utils/toast.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final email;
  late final userId;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late List<Todo> _todoList = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  getTodoList() async {
    try {
      var body = {
        "userId": userId,
      };

      var response =
          await http.post(Uri.parse("http://172.26.83.58:3001/getTodo"),
              headers: {
                "Content-Type": "application/json",
              },
              body: jsonEncode(body));

      if (response.statusCode == 200) {
        _todoList = (jsonDecode(response.body)['data'] as List)
            .map((e) => Todo.fromJson(e))
            .toList();

        setState(() {});
      } else {
        Utils.showToast("Failed to get todos, ${response.body} ");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtToken = JwtDecoder.decode(widget.token);
    userId = jwtToken["_id"];
    email = jwtToken["email"];
    getTodoList();
  }

  Future<dynamic> addTodo(title, description) async {
    try {
      if (title.isNotEmpty && description.isNotEmpty) {
        var body = {
          "userId": userId,
          "title": title,
          "description": description,
        };

        Utils.showToast(userId.toString());

        var response = await http.post(
            Uri.parse("http://172.26.83.58:3001/createTodo"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body));

        if (response.statusCode == 200) {
          Utils.showToast("Todo added successfully");
        } else {
          Utils.showToast("Failed to add todo");
        }
      } else {
        Utils.showToast("Please fill all fields");
      }
    } catch (e) {
      return e;
    }
  }

  addDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('TODO'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              TextInput(
                controller: _titleController,
                label: "Title",
                h_padding: 0.01,
              ),
              TextInput(
                controller: _descriptionController,
                label: "Description",
                h_padding: 0.01,
              )
            ]),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    addTodo(_titleController.text, _descriptionController.text);
                    _titleController.clear();
                    _descriptionController.clear();
                    Navigator.pop(this.context);
                    setState(() async {
                      await getTodoList();
                    });
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home',
              style: TextStyle(color: Colors.white, fontSize: 24)),
          backgroundColor: Colors.black,
          toolbarHeight: 60,
        ),
        body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text((index + 1).toString()),
              title: Text(_todoList[index].title),
              subtitle: Text(_todoList[index].description),
              trailing: IconButton(
                icon: const Icon(
                  Icons.cancel_rounded,
                  color: Colors.red,
                ),
                onPressed: () {
                  Utils.showToast("Delete functionality not implemented yet");
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: addDialog,
            child: const Icon(
              Icons.add_rounded,
            )));
  }
}
