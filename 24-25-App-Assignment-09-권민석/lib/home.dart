import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  List<Map<String, String>> boards = [];

  @override
  void initState() {
    super.initState();
    _fetchBoards();
  }

  Future<void> _fetchBoards() async {
    try {
      String? accessToken = await secureStorage.read(key: 'access_token');
      if (accessToken == null) {
        accessToken = await _refreshAccessToken();
      }
      if (accessToken == null) return;

      final url = Uri.parse('https://api.labyrinth30-tech.link/board');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          boards = data.map<Map<String, String>>((item) {
            return {
              'id': item['id'].toString(),
              'title': item['title'],
              'content': item['contents'],
              'viewCount': item['viewCount'].toString(),
              'createdAt': item['createdAt'],
              'updatedAt': item['updatedAt'],
              'version': item['version'].toString(),
            };
          }).toList();
        });
      }
    } catch (e) {
      print('Error during fetching boards: $e');
    }
  }

  Future<String?> _refreshAccessToken() async {
    try {
      final refreshToken = await secureStorage.read(key: 'refresh_token');
      if (refreshToken == null) return null;

      final url =
          Uri.parse('https://api.labyrinth30-tech.link/auth/token/refresh');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['access_token']?.toString();
        if (newAccessToken != null) {
          await secureStorage.write(key: 'access_token', value: newAccessToken);
          return newAccessToken;
        }
      }
    } catch (e) {
      print('Error during access token refresh: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boards'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newBoard = await context.push('/CreateBoard');
              if (newBoard != null) {
                setState(() {
                  boards.add(newBoard as Map<String, String>);
                });
              }
            },
          ),
        ],
      ),
      body: boards.isEmpty
          ? Center(child: Text('게시물을 추가해보세요!'))
          : ListView.builder(
              itemCount: boards.length,
              itemBuilder: (context, index) {
                final board = boards[index];
                return ListTile(
                  title: Text(board['title'] ?? 'Untitled'),
                  subtitle: Text(board['content'] ?? 'No content available'),
                  onTap: () async {
                    final updatedBoard = await context.push(
                      '/BoardDetails',
                      extra: board,
                    );

                    if (updatedBoard != null) {
                      setState(() {
                        boards[index] = updatedBoard as Map<String, String>;
                      });
                    }
                  },
                );
              },
            ),
    );
  }
}
