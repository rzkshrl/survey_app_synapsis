// ignore_for_file: non_constant_identifier_names

class SurveyDetailedModel {
  String? id;
  String? survey_name;
  int? status;
  int? total_respondent;
  DateTime? created_at;
  DateTime? updated_at;
  List<QuestionDetailedModel>? questions;

  SurveyDetailedModel(
      {this.id,
      this.survey_name,
      this.status,
      this.total_respondent,
      this.created_at,
      this.updated_at,
      this.questions});

  factory SurveyDetailedModel.fromJson(Map<String, dynamic> json) {
    return SurveyDetailedModel(
      id: json['id'],
      survey_name: json['survey_name'],
      status: json['status'],
      total_respondent: json['total_respondent'],
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
      questions: (json['questions'])
          .map((e) => QuestionDetailedModel.fromJson(e))
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

class QuestionDetailedModel {
  String? id;
  int? question_number;
  String? survey_id;
  String? section;
  String? input_type;
  String? question_name;
  String? question_subject;
  List<OptionModel>? options;

  QuestionDetailedModel({
    this.id,
    this.question_number,
    this.survey_id,
    this.section,
    this.question_name,
    this.question_subject,
    this.options,
  });

  factory QuestionDetailedModel.fromJson(Map<String, dynamic> json) {
    return QuestionDetailedModel(
      id: json['id'],
      question_number: json['question_number'],
      survey_id: json['survey_id'],
      section: json['section'],
      question_name: json['question_name'],
      question_subject: json['question_subject'],
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question_number": question_number,
      "survey_id": survey_id,
      "section": section,
      "question_name": question_name,
      "question_subject": question_subject,
      "options": options?.map((e) => e.toJson()).toList(),
    };
  }
}

class OptionModel {
  String? id;
  String? question_id;
  String? option_name;
  int? value;
  String? color;

  OptionModel({
    this.id,
    this.question_id,
    this.option_name,
    this.value,
    this.color,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      question_id: json['question_id'],
      option_name: json['option_name'],
      value: json['value'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question_id": question_id,
      "option_name": option_name,
      "value": value,
      "color": color,
    };
  }
}
