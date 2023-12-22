import { addDoc, collection } from "firebase/firestore"
import { db } from "../firebase/firebase_config"
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
import { useToast } from "./ui/use-toast"


function RideDialog({ name, brand, model, color, plateNumber, phoneNumber }: any) {
  const { toast } = useToast()

  const [status, _setStatus] = useState<string>('Unreserved')
  const [orderTime, _setOrderTime] = useState<Date>(new Date())
  const [pickUpLocation, setPickUpLocation] = useState<string>()
  const [dropOffLocation, setDropOffLocation] = useState<string>()
  const [isRideAdded, setIsRideAdded] = useState(false)
  const [cost, setCost] = useState('')


  const addRideOrderToFirestore = async () => {
    if (isRideAdded) {
      return;
    }
    try {
      // Get a reference to the 'rideOrders' collection
      const rideOrdersCollection = collection(db, 'Rides');

      // Add a new document to the 'rideOrders' collection with the data from the RideOrder object
      const newRideOrderRef = await addDoc(rideOrdersCollection, {
        driverName: name,
        phoneNumber: phoneNumber,
        carModel: model,
        carBrand: brand,
        carColor: color,
        plateNumber: plateNumber,
        cost: parseInt(cost),
        status: status,
        orderTime: orderTime,
        fromLocation: pickUpLocation,
        toLocation: dropOffLocation,
      });

      setIsRideAdded(true)
      console.log('Ride order added with ID:', newRideOrderRef.id);
      // 'newRideOrderRef.id' will give you the document ID of the added ride order
    } catch (error) {
      console.error('Error adding ride order:', error);
    }
  };

  const cancelRide = () => {
    setIsRideAdded(false)
  }

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
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="From location" className="text-right">
                Cost
              </Label>
              <Input
                id="From location"
                defaultValue=""
                className="col-span-3"
                onChange={(e) => setCost(e.target.value)}
              />
            </div>
          </div>
          <DialogFooter>
            <Button className="bg-green-500 text-black" type="submit" onClick={() => {
              if (isRideAdded) {
                toast({
                  title: "Cannot add another ride",
                  description: "You already have a ride in place",
                })
              } else {
                addRideOrderToFirestore()
                toast({
                  description: "Ride was added successfully",
                })
              }
            }}>Submit</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}

export default RideDialog;
