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
        address dripper;
        bytes memory initCode = // Dripper compiled w/ optimizer w/o metadata
            hex"60c0604081815234610163576000916020816102ce8038038091610023828561"
            hex"0168565b83398101031261014757516001600160a01b03808216918281036101"
            hex"5f576080526002820181811161014b571660a052803b15610147578151630e2b"
            hex"34c360e31b8152838160048183865af1801561013a5761010f575b5091806044"
            hex"8394828095519167deecedd4925facb160c01b83528160208401528188840152"
            hex"5af1503d15610109573d906001600160401b0382116100f5578251916100cf60"
            hex"1f8201601f191660200184610168565b825260203d92013e5b5161012c908161"
            hex"01a28239608051816052015260a0518160d10152f35b634e487b7160e01b8152"
            hex"6041600452602490fd5b506100d8565b6001600160401b038111610126578252"
            hex"604461007a565b634e487b7160e01b84526041600452602484fd5b5050505190"
            hex"3d90823e3d90fd5b8280fd5b634e487b7160e01b85526011600452602485fd5b"
            hex"8480fd5b600080fd5b601f909101601f19168101906001600160401b03821190"
            hex"82101761018b57604052565b634e487b7160e01b600052604160045260246000"
            hex"fdfe6080806040526000806004341593848314610126576103e85b7f9f678cca"
            hex"00000000000000000000000000000000000000000000000000000000825273ff"
            hex"ffffffffffffffffffffffffffffffffffffff7f000000000000000000000000"
            hex"0000000000000000000000000000000000000000165af1503d15610121573d67"
            hex"ffffffffffffffff8082116100f257601f603f604051937fffffffffffffffff"
            hex"ffffffffffffffffffffffffffffffffffffffffffffffe09283910116011682"
            hex"019182109111176100f2575b6100cf57005b7f00000000000000000000000000"
            hex"00000000000000000000000000000000000000ff5b7f4e487b71000000000000"
            hex"0000000000000000000000000000000000000000000060005260416004526024"
            hex"6000fd5b6100c9565b3461001856000000000000000000000000000000000000"
            hex"0000000000000000000000000000"; // padding for puzzle address overwrite
        assembly {
            mstore(add(initCode, mload(initCode)), puzzle)
            dripper := create(0, add(initCode, 0x20), mload(initCode))
        }
        dripper.call("");
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