import 'package:domain/repositories/task_progress_listener.dart';
import 'package:gem_kit/core.dart';

class TaskProgressListenerImpl extends TaskProgressListener {
  TaskHandler? ref;
  bool shouldCancel;

  TaskProgressListenerImpl({this.ref}) : shouldCancel = false;
}
