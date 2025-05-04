import 'package:domain/repositories/task_progress_listener.dart';
import 'package:gem_kit/core.dart';

class TaskProgressListenerImpl extends TaskProgressListener {
  TaskHandler? ref;
  bool shouldCancel;

  TaskProgressListenerImpl({this.ref}) : shouldCancel = false;
}

class TaskProgressListenerImpl2 extends TaskProgressListener2 {
  ProgressListener? ref;
  bool shouldCancel;

  TaskProgressListenerImpl2({this.ref}) : shouldCancel = false;
}
