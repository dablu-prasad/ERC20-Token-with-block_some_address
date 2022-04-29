// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC20_ST {
    string  public name = "ExternLab";
    string  public symbol = "EL";
    uint256 public totalSupply=100000000000000000000;
     mapping (address => uint) index;
    // Array with address 
    address[] blockaddress;

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor ()  {
        balanceOf[msg.sender] = totalSupply;
         
    }

    function addBlockAddressToArray(address blockaddr) public {
        
        blockaddress.push(blockaddr);
    }

    function validateaddaddress(address blockaddr) private {
        bool a=true;
         for(uint i=1;i<blockaddress.length;++i)
        {
            // require(blockaddr!=blockaddress[i],"address is in blacklist");
            if(blockaddr==blockaddress[i])
            {
               a=false;
            }
                   require(a==true,"address is in blacklist");
        }
 
    }

    
    // function removeBlockAddressToArray(uint index) public {
    //     // Delete does not change the array length.
    //     // It resets the value at index to it's default value,
    //     // in this case 0
    //     delete blockaddress[index];
    // }

     function removeBlockAddressfromaddress(address removeaddr) public {
      for(uint i=0;i<blockaddress.length;++i)
        {
            // require(removeaddr==blockaddress[i],"address is in blacklist");
            if(removeaddr==blockaddress[i])
            {
            delete blockaddress[i];
            }
        }
        
    }

      function getBlockAddressToArray() public view returns (address[] memory) {
        return blockaddress;
    }


    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        validateaddaddress(_to);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit   Transfer(msg.sender, _to, _value);

        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;

       emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from][msg.sender]);
       validateaddaddress(_to);
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

     emit    Transfer(_from, _to, _value);

        return true;
    }
}
