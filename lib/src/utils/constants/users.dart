import '../../domain/entities/user.dart';

List<User> users = [
  User(
      id: 1,
      username: "Kumaran",
      mail: "test@kumaran.com",
      phoneNo: "9876543211",
      password: "Kumaran@1",
      knownMails: ["test2@kumaran.com", "test3@kumaran.com"],
      createdAt: '2024-02-10 11:50:18.230'),
  User(
      id: 2,
      username: "Kumaran2",
      mail: "test2@kumaran.com",
      phoneNo: "8876543211",
      password: "Kumaran@1",
      knownMails: ["test@kumaran.com", "test3@kumaran.com"],
      createdAt: '2024-02-10 11:50:28.230'),
  User(
      id: 3,
      username: "Kumaran3",
      mail: "test3@kumaran.com",
      phoneNo: "7876543211",
      password: "Kumaran@1",
      knownMails: ["test@kumaran.com", "test2@kumaran.com"],
      createdAt: '2024-02-10 11:50:30.230'),
  User(
      id: 4,
      username: "Alex",
      mail: "alex@kumaran.com",
      phoneNo: "7876543211",
      password: "Alex@1",
      knownMails: ["test@kumaran.com", "test2@kumaran.com"],
      createdAt: '2024-02-10 11:50:40.230'),
];
