
func testEmployee() {
	let fred = Employee ( name : "Fred",
						  payGrade:1 )

	let barney = Employee ( name : "Barney",
						  payGrade:2 )

	print("testEmployee(): pass")
}


public class Employee { 
	private let name : String 
	internal  let payGrade : Int 

	init ( name: String, payGrade : Int){
		self.name = name 
		self.payGrade = payGrade
	}

}
//-----------------------------------
extension Employee: Equatable {}

public func == (lhs:Employee, rhs:Employee) -> Bool {
	return lhs.name == rhs.name && lhs.payGrade == rhs.payGrade
}
//-----------------------------------
extension Employee: Hashable { //requires Equatable
	public var hashValue: Int { return name.hashValue }
}

public func == (lhs:Employee, rhs:Employee) -> Bool {
	return lhs.name == rhs.name && lhs.payGrade == rhs.payGrade
}

//-----------------------------------
extension Employee: Comparable {}

public func < (lhs:Employee, rhs:Employee) -> Bool {
	return lhs.name < rhs.name && lhs.payGrade < rhs.payGrade
}
public func <= (lhs:Employee, rhs:Employee) -> Bool {
	return lhs.name <= rhs.name && lhs.payGrade <= rhs.payGrade
}
public func > (lhs:Employee, rhs:Employee) -> Bool {
	return lhs.name > rhs.name && lhs.payGrade > rhs.payGrade
}
public func >= (lhs:Employee, rhs:Employee) -> Bool {
	return lhs.name >= rhs.name && lhs.payGrade >= rhs.payGrade
}



	
//-----------------------------------

extension Employee: CustomStringConvertible, 
					CustomDebugStringConvertible {

	public var description: String {
		return name
	}
	public var debugDescription: String {
		return "\(name):\(payGrade)"
	}

}		


//--------------------------------------------------
public extension String{
    public var count:Int { return characters.count }
}
//--------------------------------------------------
extension String : IntegerLiteralconverible {
	public init(integerLiteral value: Int){
		self = "\(value)"
	}
}
//--------------------------------------------------
public extension String {
	public subscript (index : Int) -> String {
		get{
			return self.substringWithRange(
				Range(start: advance(self.startIndex, index),
					  end:   advance(self.startIndex,index+1)  ) //lenght of returned str 1
		}
		
	}

	public subscript(r:Range<Int>) -> String {
		get{
			return self.substringWithRange(
				Range(start:advance(self.startIndex, r.startIndex),
					  end:  advance(self.startIndex, r.endIndex)) )
		}
		
	}

}	


//--------------------------------------------------
public class Regex  : StringLiteralConvertible {

	private let pattern:String 
	private let expression: NSRegularExpression
	private let noOptions = NSRegularExpressionOptions(rawValue:0)

	public required convenience init(
					stringLiteral v: StringLiteralType){
		try! self.init(v)
	}
	public required convenience init(
					extendedGraphemeClusterLiteral v: String){
		try! self.init(v)
	}
	public required convenience init(
					unicodeScalarLiteral v: String){
		try! self.init(v)
	}
    

    public init (_ pattern: String) throws {
    	self.pattern = pattern
    	try! expression = NSRegularExpression(pattern:pattern, options:noOptions)
    }
    public func matches(input:String) -> Bool{
    	let result = expression.matchesInString (
    								input,
    								options: 	NSMatchingOptions(rawValue:0),
             						range: 		NSMakeRange(0, input.count)
    		         )
    	return result.count > 0
    }

}
//--------------------------------------------------
public func ~= (inCase: Regex, inSwitch:String) -> Bool {
	return inCase.matches(inSwitch)
}
//-------------Tilda new operator-------------------
prefix operator ~ {}
public prefix func ~ (operand:String) ->Regex{
	do { return try Regex(operand) }
	catch{
		preconditionFailure("Malformed expression: \(operand)")
	}
}
//------------- infix opertaor -------------------
infix operator ~ {associativity left precedence 130}
infix operator !~ {associativity left precedence 130}

public func ~ (lhs:Regex, rhs:String) -> Bool{
	return lhs ~= rhs
}
public func ~ (lhs:String, rhs:Regex) -> Bool{
	return rhs ~= lhs
}

public func !~ (lhs:Regex, rhs:String) -> Bool{
	return !(lhs ~= rhs)
}
public func !~ (lhs:String, rhs:Regex) -> Bool{
	return !(rhs ~= lhs)
}


//--------------------------------------------------
extension Regex: CustomStringConvertible,
				 CustomDebugStringConvertible {

   	public var description: String {return pattern}
   	public var  debugDescription: String { return pattern}
}

//--------------------------------------------------
public class PriorityQueue<I, P:Comparable> {

	public typealias NodeT = ( item:I, priority:P)
    /*  The children of node N are at 2N and 2N+1
    *  for that to work, the array has to be 1 indexed
    *  The easy solution is just not to use element 0 */
    private var queue: [NodeT!] =[nil]
    private var count: Int { return queue.count - 1  } 
    private var isSorted = false 

    public func append( item:I, priority:P){
    	queue.append( NoteT(item:item, priority:priority))
    	reheapUp()
    	isSorted = false
    }
    //------------------------
    private func reheapUp() {
    	var current = queue.count -1
    	while current > 0 && current /2 > 0 {
    		let parent = queue[current/2]
    		let child = queue[current]
    		if parent.priority < child.priority {
    			swap(&queue[current], &queue[current/2])
    		}
    		current /= 2
    	}
    }

    public func remove() -> I? {  //returns an optional
    	if (queue.count <= 1) {return nil }
    	if (queue.count == 2){ return queue.removeLast().item }
    	let largestItem = queue[1]
    	queue[1] 		= queue.removeLast()
    	reheapDown()
    	isSorted = false 
    	return largestItem.item

    }

    //------------------------
    private func reheapDown() {
    	var root = 1
    	while(true){
    		let left:NodeT! 	= 2*root > queue.count - 1 
    							?  nil : queue[2 * root]
    		let right:NodeT! 	= 2*root + 1 > queue.count - 1 
    							?  nil : queue[2*root + 1]			
    		if ( left == nil && right == nil ) { break }	
    		let child = root * 2 +  
    			(( right==nil || left.priority >= right.priority)
    												? 0 : 1 )
    		if queue[root].priority >= queue[child].priority{
    			break
    		}
    		swap ( &queue[root], &queue[child])
    		root = child													  
    	}		
	}


