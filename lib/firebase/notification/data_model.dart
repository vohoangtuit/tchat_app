import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
const  String NOTIFY_DATA ='database_local';
const String TAG_BOOKING_NO ='bookingNo';
const String TAG_EMAIL ='email';
const String TAG_TITLE ='title';
const String TAG_MONTH_DAY_YEAR ='monthDayYear';
const String TAG_AMOUNT ='totalAmount';
const String TAG_TYPE_BOOKING ='typeBooking';
const String TAG_TYPE_NOTIFY ='typeNotification';
const String NOTIFY_CLICK_ACTION ='click_action';
class DataNotifyModel{
  dynamic bookingNo;
  String? bookingId;
  String? title;
  String? monthDayYear;
  double? totalAmount;
  int? typeBooking;
  int? typeNotification;
  String? timestamp;
  dynamic deviceType;
  String? bookingStatus;
  String? bookingPayment;
  String? email;
  String? fullName;
  String? phone;
  dynamic customerCode;


  DataNotifyModel({
      this.bookingNo,
      this.bookingId,
      this.title,
      this.monthDayYear,
      this.totalAmount,
      this.typeBooking,
      this.typeNotification,
      this.timestamp,
      this.deviceType,
      this.bookingStatus,
      this.bookingPayment,
      this.email,
      this.fullName,
      this.phone,
      this.customerCode
  });

  factory DataNotifyModel.fromPayload(String payload){
    //print('payload::...:: $payload');
    var json = jsonDecode(payload) as Map<String, dynamic>;
    //Map<String, String> json =payload as Map<String, String>;
  //  print('_json $_json');
    return DataNotifyModel(
        bookingNo: json[TAG_BOOKING_NO],
        typeBooking: json['typeBooking']??0,
       typeNotification: json['typeNotification']??0,
      customerCode: json['customercode'],
    );
  }
  factory DataNotifyModel.fromRemoteMessage(RemoteMessage remoteMessage) {
    var _json = jsonDecode(remoteMessage.data['data']) as Map;
    //print("_json $_json");
  //   print('bookingNo ${_json['bookingNo']}');
   return DataNotifyModel(
      bookingNo:_json[TAG_BOOKING_NO],
      typeBooking:_json[TAG_TYPE_BOOKING],
       typeNotification: _json[TAG_TYPE_NOTIFY],
       customerCode: _json['customercode'],
    );
  }
  Map<String, dynamic> toJson() => {
    TAG_BOOKING_NO: bookingNo,
    TAG_EMAIL: email,
    TAG_TITLE: title,
    TAG_MONTH_DAY_YEAR: monthDayYear,
    TAG_AMOUNT: totalAmount,
  };

  List<DataNotifyModel> listFromSnapshot(List<QueryDocumentSnapshot> snapshots){
    List<DataNotifyModel> list =<DataNotifyModel>[];
    if(snapshots.isNotEmpty){
      for (var item in snapshots) {
        DataNotifyModel data =DataNotifyModel();
        data.bookingNo =item['bookingNo']!;
        data.bookingId =item['bookingId']!;
        data.title =item['title']!;
        data.monthDayYear =item['monthDayYear']!;
        data.totalAmount =item['totalAmount'].toDouble()!;
        data.timestamp =item['timestamp']!;
        data.typeBooking =item['typeBooking']!;
        data.deviceType =item['deviceType']!;
        data.bookingStatus =item['bookingStatus']!;
        if(item['bookingPayment']!=null){
          data.bookingPayment =item['bookingPayment']??'';
        }else{
          data.bookingPayment='';
        }

        data.email =item['email']!;
        data.fullName =item['fullName']!;
        data.phone =item['phone']!;
        list.add(data);
      }}

    return list;
  }
  @override
  String toString() {
    return '{"bookingNo": "$bookingNo", "bookingId": "$bookingId", "title": "$title", "monthDayYear": "$monthDayYear", "totalAmount": "$totalAmount", "typeBooking": $typeBooking,"typeNotification": $typeNotification, "customercode": "$customerCode","timestamp": "$timestamp", "deviceType": "$deviceType", "bookingStatus": "$bookingStatus","bookingPayment": "$bookingPayment", "email": "$email", "fullName":" $fullName", "phone": "$phone"}';
  }
}