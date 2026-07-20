import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/add_notes/add_notes_screen.dart';
import 'package:flutter_application_1/screens/splash/splash_screen.dart';
import 'package:flutter_application_1/screens/update_note/update_note_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;
  bool loading = false;
  List<Map<String, dynamic>> notes = [];

  void getNotes() async {
    setState(() {
      loading = true;
    });
    try {
      final result = await supabase.from('notes').select();
      setState(() {
        notes = result;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  await supabase.auth.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                    (context) => false,
                  );
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                for (var note in notes)
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateNoteScreen(note: note),
                        ),
                      );
                    },
                    title: Text(note['title']),
                    subtitle: Text(note['description']),
                    trailing: IconButton(
                      onPressed: () async {
                        await supabase
                            .from('notes')
                            .delete()
                            .eq('id', note['id']);
                      },
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                    ),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotesScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
