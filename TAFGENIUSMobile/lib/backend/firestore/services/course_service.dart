import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/course_model.dart';
import '../../../Model/lesson_model.dart';

class CourseService {
  final CollectionReference coursesCollection =
  FirebaseFirestore.instance.collection('courses');

  // -------- CRUD Cours --------
  Future<void> addCourse(CourseModel course) async {
    await coursesCollection.add(course.toMap());
  }

  Future<void> updateCourse(String courseId, Map<String, dynamic> data) async {
    await coursesCollection.doc(courseId).update(data);
  }

  Future<void> deleteCourse(String courseId) async {
    await coursesCollection.doc(courseId).delete();
  }

  Future<List<CourseModel>> getCourses() async {
    QuerySnapshot snapshot = await coursesCollection.get();
    return snapshot.docs
        .map((doc) => CourseModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<CourseModel?> getCourse(String courseId) async {
    DocumentSnapshot doc = await coursesCollection.doc(courseId).get();
    if (!doc.exists) return null;
    return CourseModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // -------- CRUD Lessons --------
  Future<void> addLesson(String courseId, LessonModel lesson) async {
    await coursesCollection
        .doc(courseId)
        .collection('lessons')
        .add(lesson.toMap());
  }

  Future<void> updateLesson(String courseId, String lessonId, Map<String, dynamic> data) async {
    await coursesCollection
        .doc(courseId)
        .collection('lessons')
        .doc(lessonId)
        .update(data);
  }

  Future<void> deleteLesson(String courseId, String lessonId) async {
    await coursesCollection
        .doc(courseId)
        .collection('lessons')
        .doc(lessonId)
        .delete();
  }

  Future<List<LessonModel>> getLessons(String courseId) async {
    QuerySnapshot snapshot = await coursesCollection
        .doc(courseId)
        .collection('lessons')
        .orderBy('order')
        .get();
    return snapshot.docs
        .map((doc) => LessonModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
