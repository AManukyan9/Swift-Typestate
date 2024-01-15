//
//  ElevatorSystemImpl.swift
//  Elevator
//
//  Created by Armen Manukyan on 13.01.24.
//

import Foundation

public class ElevatorSystemImpl: ElevatorSystem {
    static let shared: ElevatorSystem = ElevatorSystemImpl()
    
    var destinationQueue = [Int]()
    
    private init() {}
    
    func openDoors() {
        print("doors are opening")
    }
    
    func closeDoors() {
        print("doors are closing")
    }
    
    func move() {
        guard !destinationQueue.isEmpty else {
            print("no destination")
            return
        }
        print("going to \(destinationQueue.removeFirst())")
    }
    
    func stop() {
        print("stoping")
    }
    
    func addDestination(_ dest: Int) {
        print("added \(dest)")
        destinationQueue.append(dest)
    }
}
