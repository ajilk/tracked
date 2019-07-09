const firestoreService = require('firestore-export-import');
const serviceAccount = require('./serviceAccountKey.json');
const databaseURL = 'tracked-20e3a.firebaseio.com';

// Initiate Firebase App
firestoreService.initializeApp(serviceAccount, databaseURL);

// Start importing your data
// The array of date and location fields are optional
firestoreService.restore('file.json');
