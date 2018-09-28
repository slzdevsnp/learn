class Bird {
    var nest: Nest?
    deinit {
        println("DEINIT: This bird has flown")
    }
}

class Nest {
    unowned var owner: Bird
    deinit {
        println("DEINIT: This nest is gone")
    }
    init(owner: Bird) {
        self.owner = owner
    }
}

var bird: Bird! = Bird()
var nest: Nest! = Nest(owner: bird)

// These instances should get deallocated
// println("Nil-ing out single references...")
// bird = nil
// nest = nil

// Re-create new references
bird.nest = nest

// We can break the retain-cycle if we nil-out the cross-object references
// bird.nest = nil
// nest.owner = nil

// These instances will NOT get deallocated
println("Nil-ing references with retain-cycles...")
bird = nil
println("Nest is owned by \(nest.owner)")
nest = nil
