import 'package:so_bicos/core/external/models/job/job_api_model.dart';

final jobApiModelFake = JobApiModel(
  id: 0,
  title: "Marketing digital",
  description: "Procuro",
  category: "marketing_digital",
  author: "teste@gmail.com",
  date: DateTime.now().millisecondsSinceEpoch,
);

final jobApiModelFakeList = [
  JobApiModel(
    id: 1,
    title: "Especialista",
    description: "Procuro",
    category: "desenvolvedor",
    author: "teste@gmail.com",
    date: DateTime.now().millisecondsSinceEpoch,
  ),
  JobApiModel(
    id: 2,
    title: "Tradutor",
    description: "Procuro",
    category: "traducao",
    author: "teste@gmail.com",
    date: DateTime.now().millisecondsSinceEpoch,
  ),
];
