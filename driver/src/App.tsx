import { addDoc, collection } from "firebase/firestore"
import { db } from "./firebase/firebase_config"
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
  carModel: string
  carColor: string
  plateNumber: string
  status: string
  orderTime: Date
  fromLocation: string
  toLocation: string
}


function App() {

  const [driverName, setDriverName] = useState<string>()
  const [carModel, setCarModel] = useState<string>()
  const [carColor, setCarColor] = useState<string>()
  const [plateNumber, setPlateNumber] = useState<string>()
  const [status, _setStatus] = useState<string>('Pending')
  const [orderTime, _setOrderTime] = useState<Date>(new Date())
  const [fromLocation, setFromLocation] = useState<string>()
  const [toLocation, setToLocation] = useState<string>()

  const [_rideOrder, _setRideOrder] = useState<RideOrder>({
    driverName: "Mahmoud",
    carModel: "Toyota Corolla",
    carColor: "Red",
    plateNumber: "ABC-123",
    status: "Pending",
    orderTime: new Date("2023-12-20"),
    fromLocation: "Abdu-Basha",
    toLocation: "5th Settlement",
  })

  const addRideOrderToFirestore = async () => {
    try {
      // Get a reference to the 'rideOrders' collection
      const rideOrdersCollection = collection(db, 'Rides');

      // Add a new document to the 'rideOrders' collection with the data from the RideOrder object
      const newRideOrderRef = await addDoc(rideOrdersCollection, {
        driverName: driverName,
        carModel: carModel,
        carColor: carColor,
        plateNumber: plateNumber,
        status: status,
        orderTime: orderTime,
        fromLocation: fromLocation,
        toLocation: toLocation,
      });

      console.log('Ride order added with ID:', newRideOrderRef.id);
      // 'newRideOrderRef.id' will give you the document ID of the added ride order
    } catch (error) {
      console.error('Error adding ride order:', error);
    }
  };

  return (
    <div className="bg-white h-screen w-screen flex items-center justify-center">
      <Dialog>
        <DialogTrigger asChild>
          <Button className="rounded-xl" variant="outline">Add Ride</Button>
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
              <Label htmlFor="name" className="text-right">
                Name
              </Label>
              <Input
                id="Name"
                defaultValue=""
                className="col-span-3"
                onChange={(e) => setDriverName(e.target.value)}
              />
            </div>
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="Car Model" className="text-right">
                Car Model
              </Label>
              <Input
                id="Car Model"
                defaultValue=""
                className="col-span-3"
                onChange={(e) => setCarModel(e.target.value)}
              />
            </div>
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="To Location" className="text-right">
                To Location
              </Label>
              <Input
                id="To Location"
                defaultValue=""
                className="col-span-3"
                onChange={(e) => setToLocation(e.target.value)}
              />
            </div>
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="From location" className="text-right">
                From location
              </Label>
              <Input
                id="From location"
                defaultValue=""
                className="col-span-3"
                onChange={(e) => setFromLocation(e.target.value)}
              />
            </div>
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="Car color" className="text-right">
                Car color
              </Label>
              <Input
                id="Car color"
                defaultValue=""
                className="col-span-3"
                onChange={(e) => setCarColor(e.target.value)}
              />
            </div>
            <div className="grid grid-cols-4 items-center gap-4">
              <Label htmlFor="Plate Number" className="text-right">
                Plate Number
              </Label>
              <Input
                id="Plate Number"
                defaultValue=""
                className="col-span-3"
                onChange={(e) => setPlateNumber(e.target.value)}
              />
            </div>
          </div>
          <DialogFooter>
            <Button type="submit" onClick={addRideOrderToFirestore}>Add Ride</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}

// interface RideOrder {
//   driverName: string
//   carModel: string
//   carColor: string
//   plateNumber: string
//   status: string
//   orderTime: Date
//   fromLocation: string
//   toLocation: string
// }

export default App
