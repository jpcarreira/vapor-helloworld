import Vapor

let drop = Droplet()

// GET requests

drop.get { req in

    // returning a String
    //    return "Hello Vapor"
    
    // returning JSON
    return try JSON(node: ["message": "Hello Vapor"])
}

drop.get("hello") { req in

    return try JSON(node: ["message": "Hello page"])
}

drop.get("hello", "there") { req in
    
    return try JSON(node: ["message": "Hello there page"])
}

drop.get("hello", Int.self) { req, number in
 
    return try JSON(node: ["message": "You passed numer \(number)"])
}


// POST requests

drop.post("post") { req in
    
    guard let name = req.data["name"]?.string else {
        throw Abort.badRequest
    }
    
    return try JSON(node: ["message": "Hello \(name)"])
}


drop.run()
