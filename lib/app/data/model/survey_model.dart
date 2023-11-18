// ignore_for_file: non_constant_identifier_names

class SurveyModel {
  String? id;
  String? survey_name;
  int? status;
  int? total_respondent;
  DateTime? created_at;
  DateTime? updated_at;
  List<QuestionModel>? questions;

  SurveyModel(
      {this.id,
      this.survey_name,
      this.status,
      this.total_respondent,
      this.created_at,
      this.updated_at,
      this.questions});

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      id: json['id'],
      survey_name: json['survey_name'],
      status: json['status'],
      total_respondent: json['total_respondent'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "survey_name": survey_name,
      "status": status,
      "total_respondent": total_respondent,
      "created_at": created_at,
      "updated_at": updated_at,
      "questions": questions?.map((e) => e.toJson()).toList(),
    };
  }
}

class QuestionModel {
  String? question_name;
  String? input_type;
  String? question_id;

  QuestionModel({this.question_name, this.input_type, this.question_id});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        question_name: json['question_name'],
        input_type: json['input_type'],
        question_id: json['question_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      "question_name": question_name,
      "input_type": input_type,
      "question_id": question_id
    };
  }
}
