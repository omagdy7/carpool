import { addDoc, collection, doc, getDoc } from "firebase/firestore"
import { db } from "../firebase/firebase_config"
import { auth } from "../firebase/firebase_config"
import { Button } from "@/components/ui/button"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { useState } from "react"

interface RideOrder {
  driverName: string
  carBrand: string
  carModel: string
  carColor: string
  plateNumber: string
  status: string
  orderTime: Date
  pickUpLocation: string
  dropOffLocation: string
}


function RideDialog({ name, brand, model, color, plateNumber }: any) {

  const [status, _setStatus] = useState<string>('Pending')
  const [orderTime, _setOrderTime] = useState<Date>(new Date())
  const [pickUpLocation, setPickUpLocation] = useState<string>()
  const [dropOffLocation, setDropOffLocation] = useState<string>()


  const addRideOrderToFirestore = async () => {
    try {
      // Get a reference to the 'rideOrders' collection
      const rideOrdersCollection = collection(db, 'Rides');

      // Add a new document to the 'rideOrders' collection with the data from the RideOrder object
      const newRideOrderRef = await addDoc(rideOrdersCollection, {
        driverName: name,
        carModel: model,
        carBrand: brand,
        carColor: color,
        plateNumber: plateNumber,
        status: status,
        orderTime: orderTime,
        fromLocation: pickUpLocation,
        toLocation: dropOffLocation,
      });

      console.log('Ride order added with ID:', newRideOrderRef.id);
      // 'newRideOrderRef.id' will give you the document ID of the added ride order
    } catch (error) {
      console.error('Error adding ride order:', error);
    }
  };

  return (
    <div>
      <Dialog>
        <DialogTrigger asChild>
          <Button className="bg-green-600 text-black text-xl">Add Ride</Button>
        </DialogTrigger>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>Ride details</DialogTitle>
            <DialogDescription>
              Please enter details about your ride and click submit for the ride to appear to other students!
            </DialogDescription>
          </DialogHeader>
          <div className="grid gap-4 py-4">
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="To Location" className="text-right">
                Pickup
              </Label>
              <Input
                id="To Location"
                defaultValue=""
                className="col-span-3"
                onChange={(e) => setDropOffLocation(e.target.value)}
              />
            </div>
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="From location" className="text-right">
                Drop off
              </Label>
              <Input
                id="From location"
                defaultValue=""
                className="col-span-3"
                onChange={(e) => setPickUpLocation(e.target.value)}
              />
            </div>
          </div>
          <DialogFooter>
            <Button className="bg-green-500 text-black" type="submit" onClick={addRideOrderToFirestore}>Submit</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}

export default RideDialog;
