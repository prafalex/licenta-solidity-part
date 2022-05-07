pragma solidity ^0.8.0;

import "./carOvertake.sol";

contract CarHelper is CarOvertaking{

    uint overtakeFee = 0.0001 ether;

    modifier ratingRequire(uint _rating,uint _id){
        require(cars[_id].rating >= _rating);
        _;
    }
    function withdraw() external onlyOwner {
        address  payable _owner = payable(address(uint160(owner())));
        _owner.transfer(address(this).balance);
    }
    function setOvertakeFee(uint _fee)external onlyOwner{
        overtakeFee = _fee;
    }
    function overtake(uint _id) external payable{
        require(msg.value == overtakeFee);
        cars[_id].rating++;
    }
    function modifyName(uint _id, string calldata _Name) external ratingRequire(3, _id) justOwnerOf(_id){
    cars[_id].name = _Name;
    }
    function modifyVin(uint _id, uint _Vin) external ratingRequire(20, _id) justOwnerOf(_id) {
    cars[_id].vin = _Vin;
    }

    function CarsByOwner(address _owner) external view returns(uint[] memory){
        uint[] memory garage = new uint[](ownerCarsNo[_owner]);
        
        uint cnt = 0;
        for(uint i=0;i<cars.length;i++){
            if(carToOwner[i]==_owner){
                garage[cnt]=i;
                cnt++;
            }
        }
        return garage;
    }
}