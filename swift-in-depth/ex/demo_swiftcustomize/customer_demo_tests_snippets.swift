

//----------------------------------------
func testStringExtensions() {
	let fred ="fred"

	assert ( fred.count == fred.characters.count )

	print("testStringExtensions() : pass")  
}

func testRegex(){
	let letters = "[a-z+"
	let isALetter = try! Regex(letters)

	assert(isALetter.matches("abcdef") )
	assert(!isALetter.matches("000"))


	assert (switchTest("012") == .NUM )
	assert (switchTest("abc") == .LET )
	assert (switchTest("*!@") == .OTHER )



	assert ( isALetter ~ "abcdef"  )
	assert ( "abcdef"  ~ isALetter )
	assert ( isALetter !~ "012" )
	assert ( "012"     !~ isALetter)
    assert ( "abcdef"   ~ ~"[a-z]+" )

	print("testRegex(): pass")
}

enum MatchingType{
	case NUM,LET,OTHER
}

func switchTest( template:String) -> MatchingType{
	switch template {
		case try! Regex("[0-9]+") :  return .NUM 
		case try! Regex("[a-z]+") :  return .LET
		default					  :  return .OTHER					
	}
}


public func testPriorityQueue(){
	let q = PriorityQueue<String,Int>()
	q.append("0", priority:00); dump(q)
	q.append("1", priority:01); dump(q)
	q.append("2", priority:02); dump(q)
	q.append("3", priority:03); dump(q)
	q.append("4", priority:04); dump(q)
	q.append("5", priority:05); dump(q)

	assert (q .remove() == "5" ) ; dump(q)
	assert (q .remove() == "4" ) ; dump(q)
	assert (q .remove() == "3" ) ; dump(q)
	assert (q .remove() == "2" ) ; dump(q)
	assert (q .remove() == "1" ) ; dump(q)
	assert (q .remove() == "0" ) ; dump(q)

	print("testPriorityQueue(): pass")

}
//-------------
func fump(q:PriorityQueue<String,Int){
	debugPrint("\(q)")
}




