import 'package:firebase_core/firebase_core.dart';

//class DefaultFirebaseConfig {
//  static FirebaseOptions get platformOptions {
    /// if you want configuration for web from here
    /// and fill your data from web's google-services.json file ///
    // if (kIsWeb) {
    //   // Web
    //   return const FirebaseOptions(
    //     apiKey: '',
    //     authDomain: '',
    //     databaseURL:'',
    //     projectId: '',
    //     storageBucket: '',
    //     messagingSenderId: '',
    //     appId: '',
    //     measurementId: '',
    //   );

    /// also if you wont configuration for IOS from here
    /// and fill your data from IOS's google-services.json file ///
    // } else if (Platform.isIOS || Platform.isMacOS) {
    //   // iOS and MacOS
    //   return const FirebaseOptions(
    //     apiKey: '',
    //     authDomain: '',
    //     databaseURL:'',
    //     projectId: '',
    //     storageBucket: '',
    //     messagingSenderId: '',
    //     appId: '',
    //     measurementId: '',
    //   );
    // } else {
    //   // Android

    /// To do change your data from google-services.json file ///
    /// in this configuration we work for android only  ///
  //  return const FirebaseOptions(
   //   appId: '1:1044214255532:android:3b5fd2ca0c51e701353409',
  //    apiKey: 'AIzaSyAhemqozZXQev7UNHQaS42zI-2pgrZSWuA',
 //     projectId: 'push-notivication-224bc',
   //   androidClientId:
   //   '1044214255532-5pi7koj57edr5lq5r1ouf0hg5ci1p21r.apps.googleusercontent.com',
      // we can find it from firebase/project setting /  Cloud Messaging
  //    messagingSenderId: '1044214255532',
      // we can find it from firebase/ Authentication /Sign-in method
 //     authDomain: 'push-notivication-224bc.firebaseapp.com',
  //  );
    // }
 //// }
//}
