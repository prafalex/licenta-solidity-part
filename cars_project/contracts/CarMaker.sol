pragma solidity ^0.8.0 ;

import "./ownable.sol";

//SAFE MATH
import "./safemath.sol";

//TO DO:
//1.Implement safemath for all ++ / -- 

contract CarMaker is Ownable{
    //overflow fix

    uint vin = 16 ;
    uint vinMod = 10 ** vin;
    uint stopTime = 5 hours;
    struct Car{
        string name;
        uint vin;
        uint32 rating;
        uint32  pitTime;
        uint16 winCnt;
        uint16 lossCnt;
    }

    event newCar(uint id, string name, uint vin);

    Car[] public cars;

    mapping(uint => address) public carToOwner;
    mapping(address => uint) ownerCarsNo;

    function _CarCreate(string memory _name,uint _vin) internal{
        cars.push(Car(_name,_vin,1,uint32(block.timestamp + stopTime),0,0));
        uint id = cars.length-1;
        carToOwner[id] = msg.sender;
        ownerCarsNo[msg.sender] ++;
        emit newCar(id,_name,_vin);
    }

    function _randVin(string memory _name) private view returns(uint){
        uint randVin = uint(keccak256(abi.encodePacked(_name)));
        return randVin % vinMod;
    }

    function createRandCar(string memory _name) public{
        require(ownerCarsNo[msg.sender]==0);
        uint randVin = _randVin(_name);
        _CarCreate(_name, randVin);
    }
}


