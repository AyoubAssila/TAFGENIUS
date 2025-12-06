import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/course_model.dart';
import '../../../Model/lesson_model.dart';

class CourseService {
  final CollectionReference coursesCollection =
  FirebaseFirestore.instance.collection('courses');

  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  // ------------------------------
  // 🔥 CRUD COURS
  // ------------------------------
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
        .map((doc) =>
        CourseModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<CourseModel?> getCourse(String courseId) async {
    DocumentSnapshot doc = await coursesCollection.doc(courseId).get();
    if (!doc.exists) return null;
    return CourseModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ------------------------------
  // 🔥 CRUD LEÇONS
  // ------------------------------
  Future<void> addLesson(String courseId, LessonModel lesson) async {
    await coursesCollection
        .doc(courseId)
        .collection('lessons')
        .add(lesson.toMap());
  }

  Future<void> updateLesson(
      String courseId, String lessonId, Map<String, dynamic> data) async {
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
        .map((doc) =>
        LessonModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // ------------------------------
  // 🔥 COURS ACHETÉS (MyCourses)
  // ------------------------------
  Future<List<CourseModel>> getPurchasedCourses(String userId) async {
    DocumentSnapshot userDoc = await usersCollection.doc(userId).get();

    if (!userDoc.exists) return [];

    List<dynamic> purchased = (userDoc.data() as Map)['purchasedCourses'] ?? [];

    if (purchased.isEmpty) return [];

    QuerySnapshot snapshot = await coursesCollection
        .where(FieldPath.documentId, whereIn: purchased)
        .get();

    return snapshot.docs
        .map((doc) =>
        CourseModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // ------------------------------
  // 🔥 RECOMMENDED COURSES
  // ------------------------------
  /// RÉCUPÈRE TOUS LES COURS COMME RECOMMANDÉS
  Future<List<CourseModel>> getRecommendedCourses() async {
    QuerySnapshot snapshot =
    await coursesCollection.orderBy('createdAt', descending: true).get();

    return snapshot.docs
        .map((doc) =>
        CourseModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // ------------------------------
  // 🔥 MARQUER PROGRÈS D'UN COURS
  // ------------------------------
  Future<void> updateLessonProgress(
      String userId, String courseId, int lessonIndex, double percent) async {
    await usersCollection.doc(userId).update({
      "progress.$courseId": {
        "lessonIndex": lessonIndex,
        "percent": percent,
      }
    });
  }

  // ------------------------------
  // 🔥 FUTURE : ACHAT PAYMEE
  // ------------------------------
  Future<void> saveCoursePurchase(String userId, String courseId) async {
    await usersCollection.doc(userId).update({
      "purchasedCourses": FieldValue.arrayUnion([courseId])
    });
  }
}
