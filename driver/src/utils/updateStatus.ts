import { db } from "@/firebase/firebase_config";
import { collection, doc, getDocs, query, updateDoc, where } from "firebase/firestore";

export const updateStatus = async (userId, newStatus) => {
  console.log("userID: ", userId)
  try {
    const q = query(collection(db, 'RideRequest'), where('passengerID', '==', userId));
    const querySnapshot = await getDocs(q);

    querySnapshot.forEach(async (doc_data) => {
      try {
        const passengerRequestRef = doc(db, 'RideRequest', doc_data.id);
        await updateDoc(passengerRequestRef, {
          status: newStatus,
        });
        console.log(`Status updated successfully for document ID: ${doc_data.id}`);
      } catch (error) {
        console.error('Error updating status:', error);
      }
    });
  } catch (error) {
    console.error('Error fetching documents:', error);
  }
};
