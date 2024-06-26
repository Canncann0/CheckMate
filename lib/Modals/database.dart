import 'package:hive/hive.dart';
import 'task_model.dart';

class TaskDataBase {
  final _taskBox = Hive.box<TaskModel>('taskBox');

  List<TaskModel> get taskList => _taskBox.values.toList();

  void addTask(TaskModel task) {
    _taskBox.add(task);
  }

  void updateTask(int index, TaskModel task) {
    _taskBox.putAt(index, task);
  }

  void deleteTask(int index) {
    _taskBox.deleteAt(index);
  }
}
