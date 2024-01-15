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
            print("STATE not ready")
            self = .idle(elevator)
        case let .moving(elevator):
            print("STATE already moving")
            self = .moving(elevator)
        case let .prepare(elevator):
            print("STATE moving")
            elevator.move()
            self = .moving(elevator.transitionToMove())
        }
    }
    
    mutating func stop() {
        switch consume self {
        case let .idle(elevator):
            print("STATE already stopped")
            self = .idle(elevator)
        case let .moving(elevator):
            print("STATE stopped")
            elevator.stop()
            self = .prepare(elevator.transitionToIdle())
        case let .prepare(elevator):
            print("STATE abort preparation")
            elevator.openDoors()
            self = .idle(elevator.transitionToIdle())
        }
    }
    
    mutating func prepare() {
        switch consume self {
        case let .idle(elevator):
            print("STATE ready")
            elevator.closeDoors()
            self = .prepare(elevator.transitionToPrepare())
        case let .moving(elevator):
            print("STATE no need to prepare")
            self = .moving(elevator)
        case let .prepare(elevator):
            print("STATE already prepared")
            self = .prepare(elevator)
        }
    }
    
    mutating func openDoors() {
        switch consume self {
        case let .idle(elevator):
            print("STATE doors are open")
            self = .idle(elevator)
        case let .moving(elevator):
            print("STATE can't open doors while in move")
            self = .moving(elevator)
        case let .prepare(elevator):
            print("STATE opening doors")
            elevator.openDoors()
            self = .idle(elevator.transitionToIdle())
        }
    }
}
