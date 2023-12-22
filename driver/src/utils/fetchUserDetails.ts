import { auth, db } from "@/firebase/firebase_config";
import { DocumentData, collection, getDocs, query, where } from "firebase/firestore";


export const fetchUserDetails = async (uid) => {
  try {
    const user = auth.currentUser;
    let data = null
    if (user) {
      const usersRef = collection(db, "users")
      const q = query(usersRef, where("uid", "==", uid))
      const querySnapshot = await getDocs(q);
      querySnapshot.forEach((doc: DocumentData) => {
        data = doc.data()
        console.log(doc.id, " => ", doc.data());
      });
      return data;
    } else {
      console.log("There is no user");
      return null;
    }
  } catch (error) {
    console.error('Error fetching user details:', error);
  }
};
