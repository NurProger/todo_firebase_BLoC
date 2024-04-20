import 'package:flutter/cupertino.dart';

abstract class TodoEvent {}
class TodoAddedEvent extends TodoEvent{
  final String title;
  final String description;
  TodoAddedEvent({required this.title,required this.description});
}
class TodoDeleteEvent extends TodoEvent{
  final String docId;
  TodoDeleteEvent({required this.docId});
}
class TodoEditEvent extends TodoEvent{
  final String docId;
  final String title;
  final String description;
  TodoEditEvent(this.title, this.description, {required this.docId});
}
class TodoReadEvent extends TodoEvent{
  TodoReadEvent();
}
