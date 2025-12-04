import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Model/certificate_model.dart';

class CertificateService {
  final CollectionReference certificatesCollection =
  FirebaseFirestore.instance.collection('certificates');

  Future<void> addCertificate(CertificateModel cert) async {
    await certificatesCollection.add(cert.toMap());
  }

  Future<List<CertificateModel>> getUserCertificates(String userId) async {
    var snapshot = await certificatesCollection
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => CertificateModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
