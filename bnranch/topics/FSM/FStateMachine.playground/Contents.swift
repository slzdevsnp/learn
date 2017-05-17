
//author
//https://gist.github.com/monyschuk/e2c5609599195a30cc66
//
//code modified to compile in swift 3

import Foundation


public final class StateMachine<State: Hashable, Transition: Hashable> {
    
    public  var state: State
    
    private var transitions = [State:[Transition:State]]()
    
    public func addTransition(_ transition: Transition, from first: State, to second: State) {
        if transitions[first] == nil {
            transitions[first] = [:]
        }
        transitions[first]?[transition] = second
    }
    
    public func canAdvance(transition: Transition) -> Bool {
        return transitions[state]?[transition] != nil
    }
    
    public typealias Observer = (_ old: State, _ new: State) -> ()
    
    public func advance(_ transition: Transition, observe: Observer? = nil) -> State {
        let prev = state
        if let next = transitions[prev]?[transition], next != prev {
            state = next
            
            observe?(prev, next)
        }
        
        return state
    }
    
    public init(state: State) {
        self.state = state
    }
}

//
// Sample Usage
//
enum Switch {
    case On, Off
}
enum Position {
    case Up, Down
}

var fsm = StateMachine<Switch, Position>(state: .Off)

fsm.addTransition(.Up, from: .Off, to: .On)
fsm.addTransition(.Down, from: .On, to: .Off)

// observe change in state, if any

fsm.advance(.Up) { old, new in
    print("1st operation switched from \(old) to \(new)")
}



// alternatively, perform post-state check
if fsm.advance(.Up) != .On {
    print("hey! I expected to be On!")
}

// retrieve current state at any time
print("currently the state:\(fsm.state)")

fsm.advance(.Down) { (old, new) -> () in
    print("2nd operation switched from \(old) to \(new)")
}

// if a transition is not defined, state doesn't change
fsm.advance(.Down)
print("After two Downs the state:\(fsm.state)")



