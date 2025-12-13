// firebaseConfig.js
import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { initializeFirestore } from "firebase/firestore";

export const firebaseConfig = {
  apiKey: "AIzaSyC_YP-u8_0dUfSkavGS3cvNTR002Kqvsoc",
  authDomain: "tafgenius.firebaseapp.com",
  projectId: "tafgenius",
  storageBucket: "tafgenius.firebasestorage.app",
  messagingSenderId: "262265089602",
  appId: "1:262265089602:web:5d406465e41663e9e7c7db",
};

export const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const firestore = initializeFirestore(app, {
  experimentalAutoDetectLongPolling: true,
});
export const db = firestore;
export default firebaseConfig;
