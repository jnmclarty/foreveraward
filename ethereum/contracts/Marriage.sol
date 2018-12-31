pragma solidity ^0.5.2;

contract CommunityAwardRegistry {
    Award[] public registeredAwards;
    event contract_created(Award contractAddress);

    function createAward(string memory _awardTitle, string memory _nominatorName, string memory _awardInfo, string memory _recipientName, address payable _recipientAddr, uint _date) public {
        Award newAward = new Award(msg.sender, _nominatorName, _recipientAddr, _awardTitle, _awardInfo, _recipientName, _date);
        emit contract_created(newAward);
        registeredAwards.push(newAward);
    }

    function getDeployedAwards() public view returns (Award[] memory) {
        return registeredAwards;
    }
}

/**
 * @title Award
 * @dev The Award contract provides basic storage for names and information, and has a simple function
 * that lets people endorse the award as well as endorse endorsements.
 */
contract Award {

    event endorsement(address endorser, uint256 count);

    // Recipient address
    address payable public recipient;
    string public recipientName;
    
    // Endorsers
    address [] public endorserAddresses;
    string [] public endorserNames;

    string public awardTitle;
    string public awardInfo;

    uint public awardDate;
    
    uint256 public endorsmentCounter;
    
    /**
    * @dev Throws if called by any account other than the owner
    */
    modifier onlyRecepient() {
        require(msg.sender == recipient);
        _;
    }

    /**
    * @dev Constructor sets the original `owner` of the contract to the sender account, and
    * commits the marriage details and vows to the blockchain
    */
    
    constructor(address _nominatorAddr, string memory _nominatorName, address payable _recipientAddr, string memory _awardTitle, string memory _awardInfo, string memory _recipientName, uint _date) public {
        // TODO: Assert statements for year, month, day
        recipient = _recipientAddr;
        recipientName = _recipientName;
        
        endorserAddresses.push(_nominatorAddr);
        endorserNames.push(_nominatorName);
        
        awardTitle = _awardTitle;
        awardInfo = _awardInfo;

        awardDate = _date; 
    }

    /**
    * @dev Adds two numbers, throws on overflow.
    */
    function add(uint256 a, uint256 b) private pure returns (uint256 c) {
        c = a + b;
        assert(c >= a);
        return c;
    }

    /**
    * @dev ringBell is a payable function that allows people to celebrate the couple's marriage, and
    * also send Ether to the marriage contract
    */
    function endorse(string memory _endorserName) public payable {
        endorsmentCounter = add(1, endorsmentCounter);
        endorserAddresses.push(msg.sender);
        endorserNames.push(_endorserName);
        emit endorsement(msg.sender, endorsmentCounter);
    }

    /**
    * @dev withdraw allows the owner of the contract to withdraw all ether collected by bell ringers
    */
    function collect() external onlyRecepient {
        recipient.transfer(address(this).balance);
    }

    /**
    * @dev withdraw allows the owner of the contract to withdraw all ether collected by bell ringers
    */
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getEndorserAddress(uint8 x) public view returns (address)
    {
        return endorserAddresses[x];
    }

    function getEndorserName(uint8 x) public view returns (string memory)
    {
        return endorserNames[x];
    }

    
    /**
    * @dev returns contract metadata in one function call, rather than separate .call()s
    * Not sure if this works yet
    
    function getAwardDetails() public view returns (
        address, string, string, string, address [], string [], uint, uint256) {
        return (
            recipient,
            recipientName,
            awardTitle,
            awardInfo,
            endorserAddresses,
            endorserNames,
            awardDate,
            endorsmentCounter
        );
    } */
}
