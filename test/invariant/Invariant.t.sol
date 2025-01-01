// // SPDX-License-Identifier: SEE LICENSE IN LICENSE
// pragma solidity 0.8.20;

// import {StdInvariant} from "forge-std/StdInvariant.sol";
// import {Test} from "forge-std/Test.sol";
// import {ERC20Mock} from "../mocks/ERC20Mock.sol";
// import {PoolFactory} from "../../src/PoolFactory.sol";
// import {TSwapPool} from "../../src/TSwapPool.sol";
// import {Handler} from "./Handler.t.sol";

// contract Invariant is StdInvariant, Test {
//     ERC20Mock poolToken;
//     ERC20Mock weth;

//     PoolFactory factory;
//     TSwapPool pool; // -> this will be our poolToken/WETH pool

//     Handler handler;

//     int256 constant STARTING_X = 100e18; //starting ERC20 / poolToken
//     int256 constant STARTING_Y = 50e18; //starting WETH

//     function setUp() public {
//         weth = new ERC20Mock();
//         poolToken = new ERC20Mock();

//         factory = new PoolFactory(address(weth));
//         pool = new TSwapPool(factory.createPool(address(poolToken)));

//         poolToken.mint(address(this), uint256(STARTING_X));
//         weth.mint(address(this), uint256(STARTING_Y));

//         poolToken.approve(address(pool), type(uint256).max);
//         weth.approve(address(pool), type(uint256).max);

//         pool.deposit(
//             uint256(STARTING_Y), 
//             uint256(STARTING_Y), 
//             uint256(STARTING_X), 
//             uint64(block.timestamp)
//         );

//         handler = new Handler(pool);
//         bytes4[] memory selectors = new bytes4[](2);
//         selectors[0] = handler.deposit.selector;
//         selectors[1] = handler.swapPoolTokenForWethBasedOnOutput.selector;

//         targetSelector(FuzzSelector({addr: address(handler), selectors: selectors}));
//         targetContract(address(handler));

//         assertEq(handler.actualDeltaX(), handler.expectedDeltaX());
//     }
// }