// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Deployed to Goerli at 0x8055E7f59cE6E3a0Bdf3378DFcfF2B67d2Cb6846

contract BuyMeACoffee {
    // Event to emit when a Memo is created.
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct.
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    // List of all memmos received from friends.
    Memo[] memos;

    // Address of contract deployer.
    address payable owner;

    // Deploy logic.
    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev buy me a coffee for contract owner
     * @param _name name of the coffee buyer
     * @param _message a nice message from the coffee buyer
     */
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy a coffee with 0 ETH");

        // Add the memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // Emit a log event when a new memo is created!
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }
    
    /**
     * @dev send the entire balance store in this contract to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /**
     * @dev retrive all the memos received and stored on the blockchain
     */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }
}
