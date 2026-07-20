import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool loading = false;
  final supabase = Supabase.instance.client;

  void addNote() async {
    setState(() {
      loading = true;
    });

    try {
      await supabase.from('notes').insert({
        'title': _titleController.text,
        'description': _descriptionController.text,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Notes Screen')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
          ),
          SizedBox(height: 16),

          loading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: addNote,
                  child: Text('Add this note!!'),
                ),
        ],
      ),
    );
  }
}
