//
//  ElevatorState.swift
//  Elevator
//
//  Created by Armen Manukyan on 13.01.24.
//

import Foundation

enum ElevatorState: ~Copyable {
    case idle(Elevator<Idle>)
    case moving(Elevator<Moving>)
    case prepare(Elevator<Prepare>)
    
    init() {
        self = .idle(Elevator<Idle>())
    }
    
    mutating func move() {
        switch consume self {
        case let .idle(elevator):
            self = .idle(elevator)
        case let .moving(elevator):
            self = .moving(elevator)
        case let .prepare(elevator):
            elevator.move()
            self = .moving(elevator.transitionToMove())
        }
    }
    
    mutating func stop() {
        switch consume self {
        case let .idle(elevator):
            self = .idle(elevator)
        case let .moving(elevator):
            elevator.stop()
            self = .prepare(elevator.transitionToIdle())
        case let .prepare(elevator):
            elevator.openDoors()
            self = .idle(elevator.transitionToIdle())
        }
    }
    
    mutating func prepare() {
        switch consume self {
        case let .idle(elevator):
            elevator.closeDoors()
            self = .prepare(elevator.transitionToPrepare())
        case let .moving(elevator):
            self = .moving(elevator)
        case let .prepare(elevator):
            self = .prepare(elevator)
        }
    }
    
    mutating func openDoors() {
        switch consume self {
        case let .idle(elevator):
            self = .idle(elevator)
        case let .moving(elevator):
            self = .moving(elevator)
        case let .prepare(elevator):
            elevator.openDoors()
            self = .idle(elevator.transitionToIdle())
        }
    }
}
