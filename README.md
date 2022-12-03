# [IMKIT] Quick Start: Send Your First Message

## Intro

Through IMKIT Flutter SDK, you will be able to integrate chat into your app easily and efficiently. Follow the simple integration process below to build the chat with feature-rich experience.

## Requirements

- Flutter version 3.0.1 and later
- Dart version 2.17.1 and later
- Platform Android, iOS

## Get started

This tutorial provides you a step-by-step guide to install `IMKIT Flutter SDK` to your new project or an existing project you own with minimum efforts. Please check out the details in the complete guide and documents. You can find solutions to related issues you may face during the installations. Let's get started.

### Step 1 - Install SDK

Open `pubspec.yam` in project, then paste this:

```
imkit:
    git:
      url: https://github.com/imkit/imkit-flutter-sdk.git
```

### Step 2 - Initialize IMKIT

To integrate and run IMKIT in your app, we recommend you to initialize it in `main.dart`.

Before initializing IMKIT, you need to have two things ready.

```
1. client key
2. chat server url    
```

You can get these private values from our dashboard.

> Dashboard: https://dashboard.imkit.io/ [![img](https://camo.githubusercontent.com/3c1213cd33653f8295c79af296edf2aa3683641de7d07f06b85d559386a414e8/68747470733a2f2f692e696d6775722e636f6d2f51394a307471472e706e67)](https://camo.githubusercontent.com/3c1213cd33653f8295c79af296edf2aa3683641de7d07f06b85d559386a414e8/68747470733a2f2f692e696d6775722e636f6d2f51394a307471472e706e67)

(In order to continue this tutorial, please check out our dashboard if you don't have these values.)

> Dashboard intro: https://hackmd.io/B2ARb__GQ2SJeLOxuL8sLg

(Please check out the How to get client key tutorial)

```
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_imkit_demo/app.dart';
import 'package:imkit/imkit_sdk.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IMKit.init(IMStateBuilder()
        ..setClientKey(IMKIT_CLIENT_KEY)
        ..setChatServerURL(IMKIT_CHAT_SERVER_URL)
        );
  runZonedGuarded(() {
    runApp(const App());
  }, (error, stackTrace) {});
}

```

in `app.dart`

```
import 'package:flutter/material.dart';
import 'package:flutter_imkit_demo/rooms_widget.dart';
import 'package:imkit/imkit_sdk.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMKit Demo App',
      localizationsDelegates: IMKit.instance.localizationsDelegates,
      supportedLocales: IMKit.instance.supportedLocales,
      home: const RoomsWidget(),
      navigatorObservers: IMKit.instance.navigatorObservers,
      builder: IMKit.instance.builder(null),
    );
  }
}

```

### Step 3 - Show Chat Room List Scene

We implemented multiple default scenes in IMKIT SDK, so you don't need to generate any dart files to show the chat room list and chat room.

Choose a view controller you want to show the chat room list from and implement the following code to it.

#### 1. Prepare user data

First, we need users to get the chat started. To start, we need two things:

```
1. userId
2. username
```

Both values are string types, hence we created `currentUserId` & `currentUserNickname` for demo purposes.

(It is also completely fine to use the user data from your app)

We also created another user id (called `otherUserId`) to join the chatroom with the first user.

#### 2. Start Connecting to Chat Server

To connect to the chat server with `userId` through the `connect` method of IMKIT. Please make `userId` unique, because we need to be able to identify different users.

```
await IMKit.login(uid: <USER_ID>);
```

As for the access token from IMKIT, it will be stored permanently, and the IMKIT Flutter SDK will help handle it until you log out from IMKIT.

#### 3. Update User Info

After successfully connecting to IMKIT server with `userId`, try to update your user data including the nickname, avatar, and description.

```
IMKit.instance.action.updateMe(
		nickname: <NICKNAME>, 
		avatarUrl: <AVATAR_URL>, 
    description: <DESC>
);

```

#### 4. Create direct-chat-room

In order to demonstrate a direct chat with someone in the chatroom, we created a chatroom with otherUserId we generated previously by the `IMKit.instance.action.createDirectRoom(invitee: <otherUserId>)` method.

(By the way, chatrooms will not be created repeatedly after you executed the method over and over again. Our solid backend server team will handle this.)

#### 5. Enter chat room list scene

Here's a sample code:

```
import 'package:imkit/imkit_sdk.dart';
import 'package:imkit/widgets/rooms/im_rooms_view.dart';

class RoomsWidget extends StatelessWidget {
  const RoomsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Room')),
      body: const IMRoomsView(),
    );
  }
}

```

### Step 5 - Show Chat Room Scene

You can easily enter the chat room scene after clicking on the cell, just like using a common instant messaging app, and there is no coding required. Then you can send your first greeting to the Mock User, perhaps with a text message or an image message. The features included in the chatroom are all default, without any customization.

If there are more ideas you want to implement in your app to make it shine, please check out our documentation.