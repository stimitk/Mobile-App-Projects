import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Map<String, dynamic> note;
  const UpdateNoteScreen({super.key, required this.note});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool loading = false;
  final supabase = Supabase.instance.client;

  void updateNote() async {
    setState(() {
      loading = true;
    });
 
    try {
      await supabase
          .from('notes')
          .update({
            'title': _titleController.text,
            'description': _descriptionController.text,
          })
          .eq('id', widget.note['id']);
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
    _titleController.text = widget.note['title'];
    _descriptionController.text = widget.note['description'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('update Notes Screen')),
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
                  onPressed: updateNote,
                  child: Text('Update this note!!'),
                ),
        ],
      ),
    );
  }
}
