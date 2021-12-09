

  

# rapidpro
##### Version: 0.0.1
A Flutter package to implement the [RapidPro](https://rapidpro.io) or [TextIt](https://textit.in) firebase channel easily

  

First follow any of the below guide depending on your platform to add firebase in your project

  

-  [Add Firebase to your iOS project](https://firebase.google.com/docs/ios/setup)

  

-  [Add Firebase to your Android project](https://firebase.google.com/docs/android/setup)

  

#### Usage

You have to configure on message event to handle incoming messages through firebase cloud message 
  For example:
```Dart
firebaseMessaging.configure(
	onMessage: (msg) async {
		
	}
);
```

First import the package and create a RapidPro instance.

```Dart

import  'package:rapidpro/rapidpro.dart';

```

RapidPro class accepts the firebaseChannel, firebaseToken, workspaceToken, urn, server and optionally a name parameter

  

```Dart

RapidPro rapidPro = RapidPro(
	server: "textit.in",
	channel: "3gcr67-ascas32-41ac", // https://textit.com/c/fcm/3gcr67-ascas32-41ac/register
	urn: "yourname@example.com", // Your urn,
	fcmToken: "932v983bv298374vb237894v4982828uv2828", // Your own fcm token
	workspaceToken: "2df472f3942b4v2424284",
	name: "John Doe", // Optional
);

```

  

> You can hold this instance by using any state management package like
> provider, blocs etc for future use.

  

Now you are ready to register, start flow, send message using the above RapidPro instance

Some examples are below

  

```Dart
rapidPro.register(
	onSuccess: (String uuid){
	// Now you have the uuid, that's typically like "345v345v-v5252b3-2v3523b-42vvv22v"
	},
	onError(e){
	// Handle the error in your own way
	}
);

```

  

To start a flow you need to know the flow uuid. Example: c2v-23c44-2v3424

```Dart
rapidPro.startFlow(
	flow: "c2v-23c44-2v3424",
	onSuccess: (response){
		
	},
	onError: (e){
		
	}
);

```

  

Sending a message is very easy
```Dart
rapidPro.sendMessage(
message: "Hello",
	onSuccess: (response){
		
	},
	onError: (error){
		
	}
);

```

**Contributors:**
  

Any form of contribution will be appreciated
Feel free to reach me if you have any confusion or suggestions
[mail@hellonishad.com](mailto:mail@hellonishad.com)
