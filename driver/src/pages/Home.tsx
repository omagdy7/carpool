import RideDialog from "@/components/RideDialog"
// import { Avatar } from "@/components/ui/avatar"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { CardTitle, CardHeader, CardContent, Card } from "@/components/ui/card"
import { auth, db } from "@/firebase/firebase_config"
import { fetchUserDetails } from "@/utils/fetchUserDetails"
import { Toaster } from "@/components/ui/toaster"
import { useEffect, useState } from "react"
import { Navigate } from "react-router-dom"
import { fetchRideRequests } from "@/utils/fetchRideRequests"
import { collection, onSnapshot } from "firebase/firestore"
import { toast } from "@/components/ui/use-toast"
import { updateStatus } from "@/utils/updateStatus"
import { fetchUserIdByPhoneNumber } from "@/utils/fetchUserIdByPhoneNumber"

interface IDriver {
  uid: string,
  name: string,
  phoneNumber: string,
  plateNumber: string,
  carBrand: string,
  carModel: string,
  carColor: string,
}

interface IPassengerRequest {
  passengerName: string,
  phoneNumber: string,
  status: string,
  pickUp: string,
  dropOff: string,
}


export default function Home() {
  const [driverData, setDriverData] = useState<IDriver | null | undefined>()
  const [rideRequests, setRideRequests] = useState<IPassengerRequest[]>([])
  const [currentTrip, setCurrentTrip] = useState<IPassengerRequest | null>(null)
  const [toComplete, setToComplete] = useState(false)
  const [isLoggedIn, setIsLoggedIn] = useState(true)


  function PassengerRequestCard({ passengerName, pickUp, dropOff, status, phoneNumber }: IPassengerRequest) {
    return (
      <li className="py-2">
        <p>
          <strong>Passenger:</strong> {passengerName}
        </p>
        <p>
          <strong>Phone Number:</strong> {phoneNumber}
        </p>
        <p>
          <strong>Status:</strong> {status}
        </p>
        <p>
          <strong>Pickup:</strong> {pickUp}
        </p>
        <p>
          <strong>Dropoff:</strong> {dropOff}
        </p>
        <div className="flex justify-between mt-2">
          <Button onClick={
            async () => {
              if (currentTrip) {
                toast({
                  description: "You already have a trip consider canceling the trip to accept a new one"
                })
              } else {
                const newRideReqs = rideRequests.map((request) => {
                  if (request.phoneNumber === phoneNumber) {
                    return { ...request, status: 'Accepted' };
                  }
                  return request;
                })
                const curTrip: any = newRideReqs.find((req) => req.phoneNumber == phoneNumber)
                const userId = await fetchUserIdByPhoneNumber(phoneNumber)
                if (userId) {
                  await updateStatus(userId, "Accepted")
                }
                setCurrentTrip(curTrip)
                setRideRequests((_) => [...newRideReqs])
              }
            }
          }
            className="text-green-500 border-green-500" variant="outline">
            Accept
          </Button>
          <Button onClick={
            async () => {
              const newRideReqs = rideRequests.map((request) => {
                if (request.phoneNumber === phoneNumber) {
                  return { ...request, status: 'Cancelled' };
                }
                return request;
              })
              const userId = await fetchUserIdByPhoneNumber(phoneNumber)
              if (userId) {
                await updateStatus(userId, "Rejected")
              }
              setRideRequests(() => newRideReqs)
            }} className="border-red-500 text-red-500" variant="outline">
            Reject
          </Button>
        </div>
      </li>
    )

  }

  useEffect(() => {
    const doWork = async () => {
      if (toComplete) {
        let phoneNumber = ''
        console.log(rideRequests)
        const newRideReqs = rideRequests.map((request) => {
          if (request.status === "Accepted") {
            phoneNumber = request.phoneNumber;
            return { ...request, status: 'Completed' };
          }
          return request;
        })
        const userId = await fetchUserIdByPhoneNumber(phoneNumber)
        if (userId) {
          await updateStatus(userId, "Completed")
        }
        setRideRequests(newRideReqs)
        setCurrentTrip(null)
      }
    }
    doWork()

    return () => {
      doWork()
    }

  }, [toComplete])

  useEffect(() => {
    const user = auth.currentUser;
    async function fetchData() {
      const data: IDriver | null | undefined = await fetchUserDetails(user?.uid);
      const rideReqs: any = await fetchRideRequests()
      setDriverData(data)
      setRideRequests(rideReqs)
    }
    fetchData()
    // Firestore real-time listener for changes
    const unsubscribe = onSnapshot(collection(db, "RideRequest"), () => {
      // Call fetchData when changes occur in the specified collection
      fetchData();
    });

    return () => {
      unsubscribe()
    }
  }, [auth.currentUser, db]);

  return (
    !isLoggedIn ? <Navigate to="/login" /> :
      (
        <main className="flex flex-col gap-6 p-6 bg-gray-900 text-white min-h-screen">
          <header className="flex justify-between items-center">
            <div className="flex items-center gap-4">
              <h1 className="text-3xl font-bold">Driver Dashboard</h1>
              {/* <Avatar alt="Driver Avatar" className="w-10 h-10" src="/placeholder.svg?height=40&width=40" /> */}
              <h2 className="text-xl font-bold">{driverData?.name}</h2>
              <Badge className="bg-white text-black" variant="secondary">
                Active Driver
              </Badge>
            </div>
            <div className="flex gap-4 items-center">
              <Button onClick={
                () => {
                  setIsLoggedIn(false)
                  auth.signOut()
                }
              }
                className="text-black bg-white" variant="outline">
                Log Out
              </Button>
            </div>
          </header>
          <section className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <Card className="bg-slate-950 text-white">
              <CardHeader className="bg-slate-800">
                <CardTitle className="text-lg font-semibold">Vehicle Details</CardTitle>
              </CardHeader>
              <CardContent className="mt-5">
                <ul className="space-y-2">
                  <li>
                    <strong>Brand:</strong> {driverData?.carBrand}
                  </li>
                  <li>
                    <strong>Model:</strong> {driverData?.carModel}
                  </li>
                  <li>
                    <strong>License Plate:</strong> {driverData?.plateNumber}
                  </li>
                </ul>
              </CardContent>
            </Card>
            <Card className="bg-slate-950 text-white">
              <CardHeader className="bg-slate-800">
                <CardTitle className="text-lg font-semibold">Current Trip</CardTitle>
              </CardHeader>
              <CardContent className="mt-5">
                <p>
                  <strong>Passenger:</strong> {currentTrip?.passengerName}
                </p>
                <p>
                  <strong>Phone Number:</strong> {currentTrip?.phoneNumber}
                </p>
                <p>
                  <strong>Status:</strong> {currentTrip?.status}
                </p>
                <p>
                  <strong>Pickup:</strong> {currentTrip?.pickUp}
                </p>
                <p>
                  <strong>Dropoff:</strong> {currentTrip?.dropOff}
                </p>
                <Button
                  onClick={() => {
                    setToComplete(true);
                  }}
                  className="w-full mt-4 border-green-500 text-white" variant="outline">
                  Finish Trip
                </Button>
                <Button
                  onClick={() => {
                    const newRideReqs = rideRequests.map((request) => {
                      if (request.status === "Accepted") {
                        return { ...request, status: 'Pending' };
                      }
                      return request;
                    })
                    setRideRequests(newRideReqs)
                    setCurrentTrip(null)
                  }}
                  className="w-full mt-4 border-red-500 text-white" variant="outline">
                  Cancel Trip
                </Button>
              </CardContent>
            </Card>
            <Card className="bg-slate-950 text-white shadow-2xl transform transition hover:scale-105">
              <CardHeader className="bg-slate-800">
                <CardTitle className="text-lg font-semibold">Passenger Requests</CardTitle>
              </CardHeader>
              <CardContent className="mt-3">
                <ul className="divide-y divide-gray-600">
                  {rideRequests?.filter((rideReq) => rideReq?.status == "Pending")
                    .map((rideReq) => {
                      return (
                        < PassengerRequestCard
                          passengerName={rideReq?.passengerName}
                          pickUp={rideReq?.pickUp}
                          dropOff={rideReq?.dropOff}
                          phoneNumber={rideReq?.phoneNumber}
                          status={rideReq?.status}
                        />
                      )
                    })}
                </ul>
              </CardContent>
            </Card>
          </section>
          <div className="flex justify-end items-center mt-6">
            <RideDialog
              name={driverData?.name}
              model={driverData?.carModel}
              brand={driverData?.carBrand}
              plateNumber={driverData?.plateNumber}
              phoneNumber={driverData?.phoneNumber}
              color={driverData?.carColor}
            />
          </div>
          <footer className="mt-auto">
          </footer>
          <Toaster />
        </main>
      )
  )
}
