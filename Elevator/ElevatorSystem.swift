//
//  ElevatorSystem.swift
//  Elevator
//
//  Created by Armen Manukyan on 13.01.24.
//

import Foundation

protocol ElevatorSystem: AnyObject {
    var destinationQueue: [Int] { get }
    
    func stop()
    func openDoors()
    func closeDoors()
    func move()
    func addDestination(_ dest: Int)
}
