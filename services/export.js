const firestoreService = require('firestore-export-import');
const serviceAccount = require('./serviceAccountKey.json');
const databaseURL = 'tracked-20e3a.firebaseio.com';

// Initiate Firebase App
firestoreService.initializeApp(serviceAccount, databaseURL);

// Start exporting your data
firestoreService
  .backup('userEmail')
  .then(data => console.log(JSON.stringify(data)))
