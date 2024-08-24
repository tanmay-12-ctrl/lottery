// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract lottery {
    address public manager;
    address payable[] public participants;

    constructor() {
        manager=msg.sender;

    }
    receive() external payable { 
       participants.push(payable (msg.sender));
    } 
    function getbalance() public view returns(uint){
        return address(this).balance;
    }
    function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp,participants.length)));
        
    }
    function selectwinner() public  returns(address){
        require(msg.sender==manager);
        require(participants.length>=3);
        uint r=random();
        address payable winner;
        uint index=r%participants.length;
       winner =participants[index];
        winner.transfer(getbalance());
        participants= new address payable[](0);
    }
}