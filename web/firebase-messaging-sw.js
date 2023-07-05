importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

// todo Copy/paste firebaseConfig from Firebase Console
const firebaseConfig = {
    apiKey: "AIzaSyBJtwOgmUfAWuWrs02AZYDKmD8nglaPHeU",
    authDomain: "virtualbuild-6307d.firebaseapp.com",
    projectId: "virtualbuild-6307d",
    storageBucket: "virtualbuild-6307d.appspot.com",
    messagingSenderId: "1059832218486",
    appId: "1:1059832218486:web:7d60c16d54f5ad10787057",
    measurementId: "G-YRDN59G8GP"
  };

  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();
  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });