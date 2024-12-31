import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

class CreateBoard extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Board'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Contents',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  final createdBoard = await _createBoard(
                    titleController.text,
                    contentController.text,
                    context,
                  );

                  if (createdBoard != null) {
                    context.pop(createdBoard);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill out all fields')),
                  );
                }
              },
              child: Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, String>?> _createBoard(
      String title, String content, BuildContext context) async {
    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      if (accessToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Please log in again. Access token is missing.')),
        );
        return null;
      }

      final url = Uri.parse('https://api.labyrinth30-tech.link/board');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'title': title,
          'contents': content,
          'viewCount': 0,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          'id': data['id'].toString(),
          'title': data['title'] ?? 'Untitled',
          'content': data['contents'] ?? '',
          'viewCount': data['viewCount'].toString(),
        };
      } else {
        return null;
      }
    } catch (e) {
      print('Error during board creation: $e');
      return null;
    }
  }
}
