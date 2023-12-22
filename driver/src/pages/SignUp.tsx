import { Label } from "@/components/ui/label"
import { Input } from "@/components/ui/input"
import { Button } from "@/components/ui/button"
import { useState, useEffect } from 'react';
import { auth, db } from '../firebase/firebase_config';
import { createUserWithEmailAndPassword } from 'firebase/auth';
import { Navigate } from "react-router-dom";
import { addDoc, collection } from "firebase/firestore";

const SignUp = () => {

  const [isSignedUp, setIsSignedUp] = useState(false)

  const [email, setEmail] = useState<string>('');
  const [password, setPassword] = useState<string>('');
  const [name, setName] = useState<string>('')
  const [phoneNumber, setPhoneNumber] = useState<string>('')
  const [carBrand, setCarBrand] = useState<string>('')
  const [carModel, setCarModel] = useState<string>('')
  const [carColor, setCarColor] = useState<string>('')
  const [plateNumber, setPlateNumber] = useState<string>('')

  useEffect(() => {
    const unsubscribe = auth.onAuthStateChanged((user) => {
      if (user) {
        // User is signed in.
        console.log('User is signed in:', user);
        // TODO: redirect the user to another page or perform some other action
      } else {
        // No user is signed in.
        console.log('No user is signed in');
      }
    });

    return () => {
      unsubscribe();
    };
  }, []);

  const handleSignUp = async () => {
    try {
      // The onAuthStateChanged listener will handle the signed-in user state.
      const userCredential = await createUserWithEmailAndPassword(auth, email, password);
      const usersCollection = collection(db, 'users');
      const userUid = userCredential.user.uid; // Get the user's UID
      addDoc(usersCollection, {
        uid: userUid,
        name: name,
        phoneNumber: phoneNumber,
        carBrand: carBrand,
        carModel: carModel,
        carColor: carColor,
        plateNumber: plateNumber,
      })
      console.log('User signed up:', userCredential.user);
      setIsSignedUp(true)
    } catch (error) {
      // TODO: Handle error messages or display them to the user.
      console.error('Error signing up:', error);
    }
  };

  return (
    isSignedUp ?
      (<Navigate to="/login" />) :
      (<div className="flex justify-center items-center h-screen bg-black">
        <div className="bg-gray-900 shadow-md rounded px-8 pt-6 w-1/3 pb-8 mb-4">
          <h2 className="text-2xl font-bold mb-4">Sign Up</h2>
          <form>
            <div className="mb-4">
              <Label htmlFor="email">
                Email
              </Label>
              <Input
                id="email"
                type="email"
                placeholder="email@eng.asu.edu.eg"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
              />
            </div>
            <div className="mb-6">
              <Label htmlFor="password">
                Password
              </Label>
              <Input
                id="password"
                type="password"
                placeholder="********"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
            </div>
            <div className="mb-6">
              <Label htmlFor="name">
                Name
              </Label>
              <Input
                id="name"
                placeholder="Hamza Omar"
                value={name}
                onChange={(e) => setName(e.target.value)}
              />
            </div>
            <div className="mb-6">
              <Label htmlFor="Phone number">
                Phone number
              </Label>
              <Input
                id="Phone number"
                placeholder="01086319130"
                value={phoneNumber}
                onChange={(e) => setPhoneNumber(e.target.value)}
              />
            </div>
            <div className="mb-6">
              <Label htmlFor="brand">
                Car Brand
              </Label>
              <Input
                id="brand"
                placeholder="Toyota"
                value={carBrand}
                onChange={(e) => setCarBrand(e.target.value)}
              />
            </div>
            <div className="mb-6">
              <Label htmlFor="model">
                Car Model
              </Label>
              <Input
                id="Model"
                placeholder="Corolla"
                value={carModel}
                onChange={(e) => setCarModel(e.target.value)}
              />
            </div>
            <div className="mb-6">
              <Label htmlFor="color">
                Car Color
              </Label>
              <Input
                id="Color"
                placeholder="Silver"
                value={carColor}
                onChange={(e) => setCarColor(e.target.value)}
              />
            </div>
            <div className="mb-6">
              <Label htmlFor="plate">
                Licencse Plate
              </Label>
              <Input
                id="plate"
                placeholder="ABC-123"
                value={plateNumber}
                onChange={(e) => setPlateNumber(e.target.value)}
              />
            </div>
            <div className="flex items-center justify-between">
              <Button
                className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                type="button"
                onClick={handleSignUp}
              >
                Sign Up
              </Button>
            </div>
          </form>
        </div>
      </div>)
  );
};

export default SignUp;
