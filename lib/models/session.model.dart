// ignore_for_file: public_member_api_docs, sort_constructors_first;

import 'package:sessions/utils/classes.dart';

class SessionModel {
  final String? _id;
  final int? payAmount;
  final String? field;
  final List<IdObject>? paidUsers;
  final String? roomId;
  final String? createdBy;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? repeat;
  final int? likes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SessionModel(
    this._id, {
    this.payAmount,
    this.field,
    this.paidUsers,
    this.roomId,
    this.createdBy,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.repeat,
    this.likes,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': _id,
      'payAmount': payAmount,
      'field': field,
      'paidUsers': paidUsers!.map((x) => x.toJson()).toList(),
      'roomId': roomId,
      'createdBy': createdBy,
      'startDate': startDate?.toUtc().toIso8601String(),
      'endDate': endDate?.toUtc().toIso8601String(),
      'startTime': startTime?.toUtc().toIso8601String(),
      'endTime': endTime?.toUtc().toIso8601String(),
      'repeat': repeat,
      'likes': likes,
      'createdAt': createdAt?.toUtc().toIso8601String(),
      'updatedAt': updatedAt?.toUtc().toIso8601String(),
    };
  }

  factory SessionModel.fromJson(Map<String, dynamic> map) {
    List<IdObject> newPaidUsers = [];
    for (var item in map['paidUsers']) {
      newPaidUsers.add(IdObject.fromJson(item));
    }
    return SessionModel(
      map['_id'] != null ? map['_id'] as String : null,
      payAmount: map['payAmount'] != null ? map['payAmount'] as int : null,
      field: map['field'] != null ? map['field'] as String : null,
      paidUsers: newPaidUsers,
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
      startDate: map['startDate'] != null
          ? DateTime.parse(map['startDate']).toLocal()
          : null,
      endDate: map['endDate'] != null
          ? DateTime.parse(map['endDate']).toLocal()
          : null,
      startTime: map['startTime'] != null
          ? DateTime.parse(map['startTime']).toLocal()
          : null,
      endTime: map['endTime'] != null
          ? DateTime.parse(map['endTime']).toLocal()
          : null,
      repeat: map['repeat'] != null ? map['repeat'] as String : null,
      likes: map['likes'] != null ? map['likes'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt']).toLocal()
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt']).toLocal()
          : null,
    );
  }
}
