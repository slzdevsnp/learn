
// I String references

class Bird { 
	var nest: Nest?
	deinit{
		print("deinit: this bird has gone")
	}
}

class Nest { 
	var owner: Bird?
	deinit{
		print("deinit: this nest has gone")
	}
}


var bird: Bird! = Bird()
var nest: Nest! = Nest()

bird.nest = nest 
nest.owner = bird 

//deallocation still not happening
// bird = nil 
// nest = nil


//deallocation will happen (broking a retain cycle)
print("trying nil-ing Bird and Nest ONLY after nil-ing their inner references")

bird.nest = nil
nest.owner = nil
bird = nil 
nest = nil


// II Weak references
class WNest { 
	weak var owner: WBird?
	deinit{
		print("deinit: this Wnest has gone")
	}
}
class WBird { 
	var nest: WNest?
	deinit{
		print("deinit: this Wbird has gone")
	}
}


var bird1: WBird! = WBird()
var nest1: WNest! = WNest()
bird1.nest = nest1
nest1.owner = bird1 
print("nilling W- bird and nest WITHOUT nilling their inner references works")
nest1 = nil
bird1 = nil 

// III Unowned refernces 

class UBird { 
	var nest: UNest?
	deinit{
		print("deinit: this Ubird has gone")
	}
}

class UNest { 
	unowned var owner: UBird
	deinit{
		print("deinit: this Unest has gone")
	}
	init(owner: UBird){
		self.owner = owner
	}
}


var bird2: UBird! = UBird()
var nest2: UNest! = UNest(owner: bird2)
bird2.nest = nest2

print("nilling U- bird and nest without nilling thier inner references ")
bird2 = nil
// print(" nest is owned by \(nest2.owner)")  //# trying to access gone object induces a segfault
nest2 = nil 






