// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IPuzzleBox {
    function lock(bytes4, bool) external;
    function operate() external;
    function drip() external payable;
    function spread(address payable[] calldata, uint256[] calldata) external;
    function zip() external;
    function leak() external;
    function torch(bytes calldata) external;
    function creep() external;
    function creepForward() external payable;
    function open(uint256, bytes calldata) external;
}

contract DripperRef {
    IPuzzleBox private immutable _puzzle;
    address payable private immutable _target;

    constructor(IPuzzleBox puzzle) payable {
        unchecked {
            _puzzle = puzzle;
            _target = payable(address(uint160(address(_puzzle)) + 2));

            // operate drip
            puzzle.operate();

            // unlock torch
            address(puzzle).call( // puzzle.lock(PuzzleBox.torch.selector, false);
                hex"deecedd4"
                hex"925facb100000000000000000000000000000000000000000000000000000000"
                hex"0000000000000000000000000000000000000000000000000000000000000000"
            ); // ??? wtf
        }
    }

    fallback() external payable {
        unchecked {
            // puzzle.drip{value: msg.value == 0 ? 1000 : msg.value}();
            address(_puzzle).call{value: msg.value == 0 ? 1000 : msg.value}(hex"9f678cca");
            if (msg.value == 0) selfdestruct(_target);
        }
    }
}