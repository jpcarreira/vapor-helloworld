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

// using leaf templates

drop.get("template1") { req in
 
    return try drop.view.make("hello", Node(node: ["name": "John Doe"]))
}

drop.get("template2", String.self) { req, name in
    
    return try drop.view.make("hello", Node(node: ["name": name]))
}

drop.get("template3") { req in
    
    let users = try ["John Doe", "Jane Doe", "John Doe", "Jane Doe", "John Doe", "Jane Doe"].makeNode()
    return try drop.view.make("hello2", Node(node: ["users": users]))
}

drop.get("template4") { req in
    
    let users = try [
        ["name": "John Doe", "email": "johndoe@mail.com"].makeNode(),
        ["name": "John Doe", "email": "johndoe@mail.com"].makeNode(),
        ["name": "John Doe", "email": "johndoe@mail.com"].makeNode()
        ].makeNode()
    
    return try drop.view.make("hello3", Node(node: ["users": users]))
}

drop.get("template5") { req in
    
    guard let sayHello = req.data["sayHello"]?.bool else {
        throw Abort.badRequest
    }
    
    return try drop.view.make("hello4", Node(node: ["sayHello": sayHello]))
}

// POST requests

drop.post("post") { req in
    
    guard let name = req.data["name"]?.string else {
        throw Abort.badRequest
    }
    
    return try JSON(node: ["message": "Hello \(name)"])
}


drop.run()
