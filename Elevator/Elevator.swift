//
//  Elevator.swift
//  Elevator
//
//  Created by Armen Manukyan on 13.01.24.
//

import Foundation

public enum Idle {}
public enum Prepare {}
public enum Moving {}

public struct Elevator<State>: ~Copyable {
    private let currentFloor = 0
    private let system: ElevatorSystem
    
    private init(system: ElevatorSystem) {
        self.system = system
    }
}

extension Elevator where State == Idle {
    init() {
        self.init(system: ElevatorSystemImpl.shared)
    }
    
    consuming func transitionToPrepare() -> Elevator<Prepare> {
        Elevator<Prepare>()
    }
    
    func closeDoors() {
        system.closeDoors()
    }
}

extension Elevator where State == Prepare {
    private init() {
        self.init(system: ElevatorSystemImpl.shared)
    }
    
    consuming func transitionToMove() -> Elevator<Moving> {
        Elevator<Moving>()
    }
    
    consuming func transitionToIdle() -> Elevator<Idle> {
        Elevator<Idle>()
    }
    
    func openDoors() {
        system.openDoors()
    }
    
    func move() {
        system.move()
    }
}

extension Elevator where State == Moving {
    private init() {
        self.init(system: ElevatorSystemImpl.shared)
    }
    
    consuming func transitionToIdle() -> Elevator<Prepare> {
        return Elevator<Prepare>()
    }
    
    func stop() {
        system.stop()
    }
}
