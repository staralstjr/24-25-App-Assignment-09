import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

class BoardDetails extends StatelessWidget {
  final Map<String, String> board;

  BoardDetails({required this.board});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Board Details')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(board['title'] ?? 'Untitled', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text(board['content'] ?? 'No content available'),
            SizedBox(height: 20),
            Text('Created At: ${board['createdAt']}'),
            Text('Updated At: ${board['updatedAt']}'),
            Text('View Count: ${board['viewCount']}'),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final updatedBoard = await context.push(
                      '/EditBoard',
                      extra: board,
                    );

                    if (updatedBoard != null) {
                      Navigator.pop(context, updatedBoard);
                    }
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final success = await _deleteBoard(board['id']!, context);
                    if (success) {
                      Navigator.pop(context, 'deleted');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to delete the board.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _deleteBoard(String boardId, BuildContext context) async {
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

      final url = Uri.parse('https://api.labyrinth30-tech.link/board/$boardId');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        print('Board deleted successfully.');
        return true;
      } else {
        print('Failed to delete board. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during board deletion: $e');
      return false;
    }
  }
}
