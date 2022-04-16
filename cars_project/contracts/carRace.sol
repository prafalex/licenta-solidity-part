pragma solidity ^0.8.0;

import "./carhelper.sol";

contract carRace is CarHelper{
    // implementare fara standard de securitate
    // folosire oracle -> in viitor
    uint randNonce = 0;

    uint raceWinProb = 59;    

    function randMod(uint _modulus) internal returns(uint) {
        randNonce ++;
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))) % _modulus;
    }

    function race(uint _id,uint _opponentId) external justOwnerOf(_id){
        Car storage myCar = cars[_id];
        Car storage opponentCar = cars[_opponentId];
        uint rand = randMod(100);
        if(rand<=raceWinProb){
            myCar.winCnt ++;
            myCar.rating ++;
            opponentCar.lossCnt ++ ;
            overtakeAndMultiply(_id, opponentCar.vin);
        }else{
            myCar.lossCnt ++;
            opponentCar.winCnt ++;
            _triggerPitStop(myCar);
        }

    }
}