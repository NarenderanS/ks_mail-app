import 'package:ks_mail/src/domain/entities/mail.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';
import 'package:ks_mail/src/data/datasources/local/database/default_users.dart';

List<Mail> mails = [
  Mail(
      id: 1,
      // from: "test2@kumaran.com",
      from: mapToUserDetails(user[1]),
      to: mapToUserDetailsList([user[0]]),
      bcc: [],
      cc: [],
      subject: "Welcome email template",
      body:
          "Hey Bala!\n\nWelcome to [brand name]. We are happy to have you join our community.\n\n[Brand name] goal is to create [add goal and/or mission of your brand].\n\nWe promise to only send you emails [add how many times per week you will be sending an email].\n\nAll our emails will offer valuable information to help you along your journey and we may occasionally recommend a product that we believe in.\n\nWe hope you enjoy your time with us and, in the meantime, feel free to check our [educational resources of your brand]\n\nYours,\n[brand name]",
      draft: false,
      readedBy: [],
      starredBy: [1],
      deletedBy: [1],
      completelyDeleted: [],
      createdAt: '2024-02-11 13:30:18.230',
      updatedAt: ''),
  Mail(
      id: 2,
      // from: "test2@kumaran.com",
      from: mapToUserDetails(user[1]),
      to: mapToUserDetailsList([user[0]]),
      bcc: [],
      cc: [],
      subject: "About Verification email template",
      body:
          "Hey Bala,\n\nThank you for signing up to my weekly newsletter. Before we get started, you‘ll have to confirm your email address.\n\nClick on the button below to verify your email address and you‘re officially one of us!\n\n[CTA button]",
      draft: false,
      readedBy: [],
      starredBy: [],
      deletedBy: [],
      completelyDeleted: [],
      createdAt: '2024-02-11 03:34:18.230',
      updatedAt: ''),
  Mail(
      id: 3,
      // from: "test2@kumaran.com",
      from: mapToUserDetails(user[1]),
      to: mapToUserDetailsList([user[0]]),
      bcc: [],
      cc: [],
      subject: "About Mail body",
      body:
          "Body. The body is the actual text of the email. Generally, you'll write this just like a normal letter, with a greeting, one or more paragraphs, and a closing with your name.",
      draft: false,
      readedBy: [],
      starredBy: [1],
      deletedBy: [],
      completelyDeleted: [],
      createdAt: '2024-02-11 03:30:18.230',
      updatedAt: ''),
  Mail(
      id: 4,
      // from: "test2@kumaran.com",
      from: mapToUserDetails(user[1]),
      to: mapToUserDetailsList([user[0]]),
      bcc: [],
      cc: [],
      subject: "Sales email template",
      body:
          "Hi Bala,\n\nI hope this email finds you well. Let me start by saying that I am a big fan of your work and it has inspired me to push myself beyond what I thought were my limits!\n\nI am reaching out because [reason].\n\nAfter taking a good look at [target company] I realize that you could improve in [improvement area]. I have helped many others improve in the same area and I‘d be more than happy to talk with you about it!\n\nWould you be available for a quick call to discuss how our [product/service] could help you?\n\nRegards,\n\n[Name]",
      draft: false,
      readedBy: [],
      starredBy: [],
      deletedBy: [2],
      completelyDeleted: [],
      createdAt: '2024-02-11 03:34:18.230',
      updatedAt: ''),
  Mail(
      id: 5,
      // from: "test@kumaran.com",
      from: mapToUserDetails(user[0]),
      to: mapToUserDetailsList([user[0]]),
      bcc: mapToUserDetailsList([user[1]]),
      cc: mapToUserDetailsList([user[2]]),
      subject:
          "Test the model by displaying it.test the model by displaying it",
      body:
          "test the model by displaying it.\ntest the model by displaying it.\ntest the model by displaying it.",
      draft: false,
      readedBy: [],
      starredBy: [],
      deletedBy: [],
      completelyDeleted: [],
      createdAt: '2024-02-11 03:30:18.230',
      updatedAt: ''),
  Mail(
      id: 6,
      // from: "test@kumaran.com",
      from: mapToUserDetails(user[0]),
      to: mapToUserDetailsList([user[1]]),
      bcc: mapToUserDetailsList([user[2]]),
      cc: [],
      subject: "Shipping confirmation email template",
      body:
          "Hi Saravanan,\n\nYour [product name] is on its way!\n\nYou can expect it to arrive at your shipping address within [timeframe].\n\nThe order number is [order number].\n\nTrack your order‘s status here [Insert tracking info].\n\nThank you for shopping with us!",
      draft: false,
      readedBy: [],
      starredBy: [],
      deletedBy: [],
      completelyDeleted: [],
      createdAt: '2024-02-11 03:34:18.230',
      updatedAt: ''),
  Mail(
      id: 7,
      // from: "test@kumaran.com",
      from: mapToUserDetails(user[0]),
      to: mapToUserDetailsList([user[1], user[2]]),
      bcc: [],
      cc: [],
      subject: "Invoice email template",
      body:
          "Hi All,\n\nHere is the invoice for the [industry] services we provided for the period of [date] until [date].\n\nYou can easily make the payment by clicking here [payment link].\n\nYou can use the following link to download a copy of your invoice in CSV or PDF: [insert link]\n\nIf you have any questions feel free to reach out.\n\nThank you for your trust",
      draft: false,
      readedBy: [],
      starredBy: [],
      deletedBy: [],
      completelyDeleted: [],
      createdAt: '2024-02-11 03:30:18.230',
      updatedAt: ''),
  Mail(
      id: 8,
      // from: "test@kumaran.com",
      from: mapToUserDetails(user[0]),
      to: mapToUserDetailsList([user[1]]),
      bcc: [],
      cc: [],
      subject: "Abandoned cart email template",
      body:
          "Hey Saravanan,\n\nGood news! The [product] is still in your cart, patiently waiting to become yours!\n\nMake sure you order before [date] to enjoy a [% discount]\n\nClick on the button below to visit the checkout page.\n\n[CTA to cart]",
      draft: false,
      readedBy: [],
      starredBy: [1],
      deletedBy: [],
      completelyDeleted: [],
      createdAt: '2024-02-11 03:34:18.230',
      updatedAt: ''),
  Mail(
      id: 9,
      // from: "test2@kumara.com",
      from: mapToUserDetails(user[1]),
      to: mapToUserDetailsList([user[0]]),
      bcc: [],
      cc: [],
      subject: "Review email template",
      body:
          "Hi Bala,\n\nYou recently purchased [product] from [your company].\n\nWe hope that you are enjoying it as much as we do! In fact, we‘d like your honest opinion!\n\nYour insights could help many other customers decide whether our products are worth buying.\n\nTherefore, if you have 5 minutes to spare, please leave your review on [product/service].\n\n[Link to reviews]\n\nThank you!",
      draft: false,
      readedBy: [],
      starredBy: [],
      deletedBy: [],
      completelyDeleted: [],
      createdAt: '2024-02-11 03:34:18.230',
      updatedAt: ''),
  Mail(
      id: 10,
      // from: "test@kumaran.com",
      from: mapToUserDetails(user[0]),
      to: mapToUserDetailsList([user[1], user[2], user[3]]),
      bcc: [],
      cc: [],
      subject: "Survey email template",
      body:
          "Hi all\n\nWe hope that you enjoy our [product/service]!\n\nWe are always looking to improve our services. As such, we would appreciate it if you could give us [amount of time] of your time to fill out the following survey.\n\n[Link or CTA to survey]\n\nYour answer will be used to help us improve our products and services.\n\nMany thanks,\n\n[Company name]",
      draft: false,
      readedBy: [],
      starredBy: [],
      deletedBy: [],
      completelyDeleted: [],
      createdAt: '2024-02-11 03:34:18.230',
      updatedAt: ''),
  Mail(
      id: 11,
      // from: "test2@kumaran.com",
      from: mapToUserDetails(user[1]),
      to: [mapToUserDetails(user[0])],
      bcc: [mapToUserDetails(user[0]), mapToUserDetails(user[2])],
      cc: [mapToUserDetails(user[1])],
      subject: "Customer satisfaction email template",
      body:
          "Hi Bala,\n\nThanks for choosing us! We are always looking to improve our [products/services].\n\nFor this reason, we‘d like to ask you a question:\n\nWhat do you think we could do to improve our services?\n\nHit that reply button and let us know!\n\nRegards,\n\n[Company‘s name]",
      draft: false,
      readedBy: [],
      starredBy: [2],
      deletedBy: [],
      completelyDeleted: [],
      createdAt: '2024-02-09 03:34:18.230',
      updatedAt: '2024-02-10 13:34:18.230'),
  Mail(
      id: 12,
      // from: "test@kumaran.com",
      from: mapToUserDetails(user[0]),
      to: [],
      bcc: [],
      cc: [mapToUserDetails(user[2])],
      subject: "Customer satisfaction email template",
      body:
          "Hi Mani,\n\nThanks for choosing us! We are always looking to improve our [products/services].\n\nFor this reason, we‘d like to ask you a question:\n\nWhat do you think we could do to improve our services?\n\nHit that reply button and let us know!\n\nRegards,\n\n[Company‘s name]",
      draft: true,
      readedBy: [],
      starredBy: [],
      deletedBy: [],
      completelyDeleted: [],
      createdAt: '2024-02-11 03:34:18.230',
      updatedAt: ''),
];
