// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IMage {
    function takeDamage() external returns (bytes32);
}

contract DarkHuffoor {

    uint256 public immutable gasLimit;
    uint256 public health = 100;
    
    bytes32 public darkSpell;

    constructor(uint256 _gasLimit) {
        gasLimit = _gasLimit;
    }

    function attack(address _target, bytes32 _darkSpell) external {
        darkSpell = _darkSpell;

        bytes32 counterspell = IMage(_target).takeDamage{ gas: gasLimit }();

        if (_canDeflect(darkSpell, counterspell)) {
            health -= 100;
        }
    }

    /// @dev _counterspell deflects if its bits are reverse of _spell's bits
    function _canDeflect(
        bytes32 _spell, 
        bytes32 _counterspell
    ) private pure returns (bool) {

        for (uint256 i = 0; i < 256; i++) {
            uint256 bit1 = (uint256(_spell) >> i) % 2;
            uint256 bit2 = (uint256(_counterspell) >> (255 - i)) % 2;

            if (bit1 != bit2) {
                return false;
            }
        }

        return true;
    }

}
