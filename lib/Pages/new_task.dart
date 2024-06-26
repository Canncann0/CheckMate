import 'package:checkmate/Modals/task_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AddNewTask extends StatefulWidget {
  final Function(TaskModel) onSave;

  AddNewTask({required this.onSave});

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _titleError;
  String? _descriptionError;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: MediaQuery.of(context).size.height * 0.95,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () {
                Navigator.of(context).pop();
              }, icon: Icon(Icons.close))
            ],
          ),
          Text(
            'Yeni Görev Ekle',
            style: GoogleFonts.plusJakartaSans(fontSize: 24,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24.0),
          TextField(
            
            controller: _titleController,
            decoration: InputDecoration(
              
              labelText: 'Görev',
              labelStyle: GoogleFonts.plusJakartaSans(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              errorText: _titleError,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: HexColor("EF9C66")),
              ),
            ),
          ),
          
          SizedBox(height: 16.0),
          TextField(
            
            maxLines: 3,
            controller: _descriptionController,
            decoration: InputDecoration(
              
              labelText: 'Görev Açıklaması',
              labelStyle: GoogleFonts.plusJakartaSans(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              errorText: _descriptionError,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: HexColor("EF9C66")),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _saveTask, // Butona tıklayınca _saveTask fonksiyonu çağrılır
            iconAlignment: IconAlignment.start,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: HexColor("#EF9C66"),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(width: 1.0, color: Colors.black),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add),
                SizedBox(width: 8),
                Text("Görev Ekle", style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  
                ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveTask() {
    setState(() {
      _titleError = _titleController.text.isEmpty ? 'Görev başlığı boş olamaz' : null;
      _descriptionError = _descriptionController.text.isEmpty ? 'Görev açıklaması boş olamaz' : null;
    });

    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      return;
    }

    TaskModel newTask = TaskModel(
      title: _titleController.text,
      description: _descriptionController.text,
    );

    widget.onSave(newTask);

    _titleController.clear();
    _descriptionController.clear();

    Navigator.of(context).pop();
  }
}
