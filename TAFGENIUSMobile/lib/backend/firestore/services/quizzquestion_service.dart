import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/quizz_model.dart';
import '../../../Model/question_model.dart';

class QuizService {
  final CollectionReference quizzesCollection =
  FirebaseFirestore.instance.collection('quizzes');

  // CRUD Quiz
  Future<void> addQuiz(QuizModel quiz) async {
    await quizzesCollection.add(quiz.toMap());
  }

  Future<QuizModel?> getQuiz(String quizId) async {
    DocumentSnapshot doc = await quizzesCollection.doc(quizId).get();
    if (!doc.exists) return null;
    return QuizModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  Future<List<QuizModel>> getCourseQuizzes(String courseId) async {
    var snapshot = await quizzesCollection.where('courseId', isEqualTo: courseId).get();
    return snapshot.docs
        .map((doc) => QuizModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // CRUD Questions (sous-collection quiz/{quizId}/questions)
  Future<void> addQuestion(String quizId, QuestionModel question) async {
    await quizzesCollection
        .doc(quizId)
        .collection('questions')
        .add(question.toMap());
  }

  Future<List<QuestionModel>> getQuestions(String quizId) async {
    var snapshot = await quizzesCollection
        .doc(quizId)
        .collection('questions')
        .get();
    return snapshot.docs
        .map((doc) => QuestionModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> updateQuestion(String quizId, String questionId, Map<String, dynamic> data) async {
    await quizzesCollection
        .doc(quizId)
        .collection('questions')
        .doc(questionId)
        .update(data);
  }

  Future<void> deleteQuestion(String quizId, String questionId) async {
    await quizzesCollection
        .doc(quizId)
        .collection('questions')
        .doc(questionId)
        .delete();
  }
}
