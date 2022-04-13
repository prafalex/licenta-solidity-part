pragma solidity ^0.8.13;

import "@openzeppelin/contracts/ownership/Ownable.sol";

import "./CarMaker.sol";

// using CryptoKittyes inferface
contract CryptoKittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract CarOvertaking is CarMaker{
    

    CryptoKittyInterface ckContract;

    modifier ownerOf(uint _id){
      require(msg.sender == carToOwner[_id]);
      _;
    }
    function setCkContractAddress(address _address) external onlyOwner{
        ckContract = CryptoKittyInterface(_address);
    }

    function _triggerPitStop(Car storage _car) internal {
      _car.pitTime = uint32(now + stopTime);
    }

    function _readyToGo(Car storage _car) internal view returns (bool){
      return (_zombie.pitTime <= now);
    }


    function overtakeAndMultiply(uint _id, uint _targetVin) internal ownerOf(_id){
        Car storage myCar = cars[_id];
        require(_readyToGo(myCar));
        _targetVin= _targetVin % vinMod;
        uint newVin = (myCar.vin + _targetVin) / 2 ;    
        _CarCreate("NoName", newVin);
        _triggerPitStop(myCar);
    }

    function overtakeCK(uint _id, uint _ckId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = ckContract.getKitty(_ckId);
    overtakeAndMultiply(_id, kittyDna);
  }

}