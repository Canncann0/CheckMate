import 'package:checkmate/Modals/task_model.dart';
import 'package:checkmate/Pages/new_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _taskBox = Hive.box<TaskModel>('taskBox');

  void _showAddTaskModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: HexColor("F1F4F8"),
      isScrollControlled: true,
      showDragHandle: false,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AddNewTask(
          onSave: (newTask) {
            setState(() {
              _taskBox.add(newTask);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Görev Kaydedildi 👍',
                      style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                    ),
                  ],
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.fromLTRB(24, 0, 24, 70),
                backgroundColor: HexColor("#7BD3EA"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                duration: Duration(seconds: 2),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("F1F4F8"),
      
      appBar: AppBar(
        forceMaterialTransparency: false,
        surfaceTintColor: HexColor("F1F4F8"),
        backgroundColor: HexColor("F1F4F8"),
        foregroundColor: HexColor("000000"),
        scrolledUnderElevation: 8,
        shadowColor: Colors.white,
        elevation: 0,
        title: Text('Görevlerim', 
        style:  GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ) ,),
      ),
      body: ValueListenableBuilder(
        valueListenable: _taskBox.listenable(),
        builder: (context, Box<TaskModel> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/chess.png"),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text('Şahmat Zamanı, Haydi İlk Görevini Ekle', 
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ), ),
                  ),
                  
                ],
              )
              
              ,);
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final task = box.getAt(index);
              return Dismissible(
                
                key: Key(task!.key.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    task.delete();
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 2,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Görev Silindi ',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.fromLTRB(24, 0, 24, 70),
                      duration: Duration(seconds: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: HexColor("FF8080"),
                    ),
                  );
                },
                background: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: HexColor("FF8080"),
                    ),
                    
                    //padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.only(right:16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      
                    ),
                  ),
                ),
                
                child: InkWell(
                  onTap: () {
                    setState(() {
                      task.isCompleted = !task.isCompleted;
                      task.save();
                    });

                    if (task.isCompleted){
                      ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 4,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Şahmat, tebrikler 👏 ',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.fromLTRB(24, 0, 24, 70),
                      duration: Duration(seconds: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      backgroundColor: HexColor("ACE1AF"),
                    ),
                  );
                    }
                  },
                  child: Card(
                    color: task.isCompleted ? HexColor("#EF9C66") : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(width: 1),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  task.title,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                              ),
                              Icon(
                                task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            task.description,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.normal
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskModal(context);
        },
        child: Icon(Icons.add),
        shape: CircleBorder(side: BorderSide(width: 1)),
        backgroundColor: HexColor("#EF9C66"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
