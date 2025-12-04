import 'package:cloud_firestore/cloud_firestore.dart';

class CertificateModel {
  String id;
  String userId;
  String courseId;
  String quizId;
  String nomEtudiant;
  String nomCours;
  DateTime dateEmission;
  String urlCertificat;

  CertificateModel({
    this.id = '',
    required this.userId,
    required this.courseId,
    required this.quizId,
    required this.nomEtudiant,
    required this.nomCours,
    required this.dateEmission,
    required this.urlCertificat,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'courseId': courseId,
      'quizId': quizId,
      'nomEtudiant': nomEtudiant,
      'nomCours': nomCours,
      'dateEmission': dateEmission,
      'urlCertificat': urlCertificat,
    };
  }

  factory CertificateModel.fromMap(Map<String, dynamic> map, String id) {
    return CertificateModel(
      id: id,
      userId: map['userId'] ?? '',
      courseId: map['courseId'] ?? '',
      quizId: map['quizId'] ?? '',
      nomEtudiant: map['nomEtudiant'] ?? '',
      nomCours: map['nomCours'] ?? '',
      dateEmission: (map['dateEmission'] as Timestamp?)?.toDate() ?? DateTime.now(),
      urlCertificat: map['urlCertificat'] ?? '',
    );
  }
}
