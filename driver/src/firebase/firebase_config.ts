// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCofH1i8LAIgU05wne6tajXtEAaRaUFWdE",
  authDomain: "carpool-3cd5c.firebaseapp.com",
  projectId: "carpool-3cd5c",
  storageBucket: "carpool-3cd5c.appspot.com",
  messagingSenderId: "824587935735",
  appId: "1:824587935735:web:2ee510b499aadd605298f2",
  measurementId: "G-9SBDWH6CLR"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app)
