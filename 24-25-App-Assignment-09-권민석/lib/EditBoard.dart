import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class EditBoard extends StatelessWidget {
  final Map<String, String> board;
  final Function(Map<String, String>) onEdit;

  EditBoard({required this.board, required this.onEdit});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = board['title']!;
    contentController.text = board['content']!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Board'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
                final updatedBoard = {
                  'id': board['id']!,
                  'title': titleController.text,
                  'contents': contentController.text, // 서버가 기대하는 필드명 확인
                  'viewCount': board['viewCount']!,
                  'createdAt': board['createdAt']!,
                  'updatedAt': DateTime.now().toIso8601String(),
                  'version': board['version']!,
                };

                final success = await _updateBoard(updatedBoard, context);
                if (success) {
                  onEdit(updatedBoard);
                  context.pop(updatedBoard);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Failed to update board. Please try again.')),
                  );
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _updateBoard(
      Map<String, String> updatedBoard, BuildContext context) async {
    try {
      final secureStorage = FlutterSecureStorage();
      final accessToken = await secureStorage.read(key: 'access_token');
      if (accessToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Please log in again. Access token is missing.')),
        );
        return false;
      }

      final url = Uri.parse(
          'https://api.labyrinth30-tech.link/board/${updatedBoard['id']}');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'title': updatedBoard['title'],
          'contents': updatedBoard['contents'],
        }),
      );

      if (response.statusCode == 200) {
        print('Board updated successfully.');
        return true;
      } else {
        print('Failed to update board. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during board update: $e');
      return false;
    }
  }
}
