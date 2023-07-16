import 'package:equatable/equatable.dart';

import '../../data/models/inscription_model.dart';

class Inscription extends Equatable {
  final InscriptionElement inscription;
  final String? auth;

  Inscription({required this.inscription, this.auth});

  @override
  List<Object?> get props => [inscription];
}
