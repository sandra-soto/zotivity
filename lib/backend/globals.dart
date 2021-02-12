import 'package:zotivity/models/user.dart';
import '../backend/localStore.dart';
import 'database.dart';

String currentUserId = '';
User currentUser;
DatabaseProvider db = DatabaseProvider.db;
localStore localInfo= localStore();