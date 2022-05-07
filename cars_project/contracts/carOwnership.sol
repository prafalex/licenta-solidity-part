pragma solidity ^0.8.0;

import "./carRace.sol";
import "./erc721.sol";

//natspec comments
/// @title Car Games Project
/// @author Praf Alexandru

/// TO DOs :


// TO DOs:
// 1. tranfer to addres 0 fix !!
// 2.auction logic ??
// resources : OpenZeppelin ERC 721

 

contract CarOwnership is carRace,ERC721{
    // implementing ERC 721 standard
    mapping(uint => address) transferApprovals;

    function balanceOf(address _owner) external override view returns (uint256) {
    return ownerCarsNo[_owner];
     }
    function ownerOf(uint256 _tokenId) external override view returns (address) {
    return carToOwner[_tokenId];
    }

    function _transfer(address _from,address _to, uint256 _tokenId) private{
        ownerCarsNo[_from] --;
        ownerCarsNo[_to] ++;
        carToOwner[_tokenId]=_to;
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external override payable {
        require(carToOwner[_tokenId] == msg.sender || transferApprovals[_tokenId] == msg.sender);
        _transfer(_from, _to, _tokenId);(_from,_to,_tokenId);
    }


    function approve(address _approved, uint256 _tokenId) external override payable justOwnerOf(_tokenId){
        transferApprovals[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }

}
