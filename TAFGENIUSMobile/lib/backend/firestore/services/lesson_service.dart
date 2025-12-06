import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/lesson_model.dart';

class LessonService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<LessonModel>> getLessonsByCourse(String courseId) {
    return _db
        .collection('courses')
        .doc(courseId)
        .collection('lessons')
        .orderBy('order')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => LessonModel.fromMap(doc.data(), doc.id))
        .toList());
  }
}
