import { auth, db } from "@/firebase/firebase_config";
import { DocumentData, collection, getDocs, query, where } from "firebase/firestore";
import { fetchUserDetails } from "./fetchUserDetails";


export const fetchRideRequests = async () => {
  const user = auth.currentUser;
  try {
    let data: any[] = []
    if (user) {
      const usersRef = collection(db, "RideRequest")
      const q = query(usersRef, where("status", "==", "Pending"))
      const querySnapshot = await getDocs(q);
      querySnapshot.forEach((doc: DocumentData) => {
        data.push(doc.data())
      });
      const rideReqs = data?.map(async (rideReq) => {
        const passengerData: any = await fetchUserDetails(rideReq.passengerID);
        return {
          passengerName: passengerData?.name,
          phoneNumber: passengerData?.phoneNumber,
          status: rideReq.status,
          pickUp: rideReq.pickUp,
          dropOff: rideReq.dropOff
        }
      })
      const rides = await Promise.all(rideReqs)
      return rides;
    } else {
      console.log("There is no user");
      return [];
    }
  } catch (error) {
    console.error('Error fetching ride requests', error);
  }
};
