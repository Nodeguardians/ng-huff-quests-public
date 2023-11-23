// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { stdJson } from "forge-std/StdJson.sol";
import { Test } from "forge-std/Test.sol";

contract HuffDeployer is Test {

    using stdJson for string;

    function deploy(string memory _path) public returns (address created) {
        return deploy(_path, new string[](0), 0);
    }

    function deploy(string memory _path, uint256 _value) public returns (address created) {
        return deploy(_path, new string[](0), _value);
    }

    function deploy(
        string memory _path, 
        string[] memory _constants, 
        uint256 _value
    ) public returns (address created) {
        bytes memory out = getBytecode(_path, _constants);
        assembly {
            created := create(_value, add(out, 0x20), mload(out))
        }
        require(created != address(0));
    }

    function getBytecode(
        string memory _path,
        string[] memory _constants
    ) public returns (bytes memory) {

        // The backend will build an artifact prior
        string memory artifactPath = string.concat("artifacts/", _path, ".json");

        if (vm.isFile(artifactPath)) {
            string memory artifactJson = vm.readFile(artifactPath);
            
            return artifactJson.readBytes(".bytecode");
        }

        // But if on the user's machine, run ffi
        string[] memory inputs = new string[](3);
        inputs[0] = "huffc";
        inputs[1] = _path;
        inputs[2] = "-b";
        for (uint256 i = 0; i < _constants.length; i++) {
            inputs[3 + i * 2] = "-c";
            inputs[4 + i * 2] = _constants[i];
        }
        return vm.ffi(inputs);

    }

}