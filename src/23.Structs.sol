// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Structs {
    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address => Car) public carsByOwner;

    function examples() external {
        Car memory toyota = Car("Toyota", 1990, msg.sender);

        Car memory lambo = Car({model: "lambo", year: 1980, owner: msg.sender});

        Car memory  tesla;
        tesla.model = "Tesal";
        tesla.year = 2000;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);
        cars.push(Car("Ferrari", 1970, msg.sender));

        Car memory _car = cars[0];
        _car.model = "Toyota2";
        _car.year;
        _car.owner;

        // Car storage _car1 = cars[0];
        // _car1.model = "Toyota1";
        // delete _car1.owner;
        // delete cars[1];
    }
}