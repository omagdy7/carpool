import { Button } from "@/components/ui/button"
import { CardTitle, CardDescription, CardHeader, CardContent, Card } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"

export default function LandingPage() {
  return (
    <main key="1" className="bg-black min-h-screen px-4 py-8 md:px-16 lg:px-24">
      <header className="flex justify-between items-center mb-8">
        <h1 className="text-4xl font-bold text-white">Carpool</h1>
        <div className="space-x-4">
          <Button className="text-white bg-gray-700" variant="outline">
            <a href="/login">Login</a>
          </Button>
          <Button className="bg-blue-500 text-white">
            <a href="/signup">Sign Up</a>
          </Button>
        </div>
      </header>
      <section className="max-w-2xl mx-auto space-y-8">
        <Card className="bg-gray-950 text-white border-2 border-amber-400">
          <CardHeader>
            <CardTitle>Welcome to Carpool</CardTitle>
            <CardDescription>Join our community and share your journey.</CardDescription>
          </CardHeader>
          <CardContent>
            <p className="text-gray-300">
              Find or offer rides, Made by students for students ❤️ ❤️
            </p>
          </CardContent>
        </Card>
        <div className="flex justify-center">
          <Badge className="text-lg font-bold text-black bg-yellow-500" />
        </div>
      </section>
      <footer className="mt-16 text-center text-gray-500">
        <p>© 2023 Carpool. All rights reserved.</p>
      </footer>
    </main>
  )
}

