// // SPDX-License-Identifier: SEE LICENSE IN LICENSE
// pragma solidity 0.8.20;

// import {Test, console2} from "forge-std/Test.sol";
// import {TSwapPool} from "../../src/TSwapPool.sol";
// import {ERC20Mock} from "../mocks/ERC20Mock.sol";

// contract Handler is Test {
//     TSwapPool pool;
//     ERC20Mock weth;
//     ERC20Mock poolToken;

//     int256 public deltaY;
//     int256 public deltaX;

//     int256 public expectedDeltaX;
//     int256 public expectedDeltaY;

//     int256 public actualDeltaX;
//     int256 public actualDeltaY;

//     address LIQUIDITY_PROVIDER = makeAddr("user");
//     address SWAPPER = makeAddr("swapper");

//     constructor(TSwapPool _pool) {
//         pool = _pool;
//         weth = ERC20Mock(_pool.getWeth());
//         poolToken = ERC20Mock(_pool.getPoolToken());
//     }

//     function swapPoolTokenForWethBasedOnOutput(uint256 outputWeth) public {
//         outputWeth = bound(outputWeth, 0, type(uint64).max);
//         if(outputWeth >= weth.balanceOf(address(pool))) {
//             return;
//         }

//         uint256 poolTokenAmount = pool.getInputAmountBasedOnOutput(outputWeth, poolToken.balanceOf(address(pool)), weth.balanceOf(address(pool)));

//         if(poolTokenAmount >= type(uint64).max) { 
//             return;
//         }
//         wethAmount = bound(wethAmount, 0, type(uint64).max);

//         startingY = int256(weth.balanceOf(address(this)));
//         startingX = int256(poolToken.balanceOf(address(this)));

//         expectedDeltaY = int256(-1) * int256(outputWeth);
//         expectedDeltaX = int256(pool.getPoolTokensToDepositBasedOnWeth(poolTokenAmount));

//         if(poolToken.balanceOf(SWAPPER) < poolTokenAmount) {
//             poolToken.mint(user, poolTokenAmount - poolToken.balanceOf(SWAPPER) + 1);
//         }

//         vm.startPrank(SWAPPER);
//         poolToken.approve(address(pool), type(uint64).max);
//         pool.swapExactOutput(poolToken, weth, wethAmount, uint64(block.timestamp));
//         vm.stopPrank();

//         int256 endingY = int256(weth.balanceOf(address(this)));
//         int256 endingX = int256(poolToken.balanceOf(address(this)));

//         actualDeltaY = int256(endingY) - int256(startingY);
//         actualDeltaX = int256(endingX) - int256(startingX);
//     }

//     function deposit(uint256 wethAmount) public {
//         wethAmount = bound(wethAmount, 0, type(uint64).max);

//         startingY = int256(weth.balanceOf(address(this)));
//         startingX = int256(poolToken.balanceOf(address(this)));

//         expectedDeltaY = int256(wethAmount);
//         expectedDeltaX = int256(getPoolTokensToDepositBasedOnWeth(wethAmount));

//         // we do the deposit here
//         vm.startPrank(LIQUIDITY_PROVIDER);
//         weth.mint(LIQUIDITY_PROVIDER, wethAmount);
//         poolToken.mint(LIQUIDITY_PROVIDER, uint256(expectedDeltaX));

//         weth.approve(address(pool), type(uint256).max);
//         poolToken.approve(address(pool), type(uint256).max);

//         pool.deposit( wethAmount, 0, uint256(expectedDeltaX), uint64(block.timestamp));
//         vm.stopPrank();

//         int256 endingY = int256(weth.balanceOf(address(this)));
//         int256 endingX = int256(poolToken.balanceOf(address(this)));

//         actualDeltaY = int256(endingY) - int256(startingY);
//         actualDeltaX = int256(endingX) - int256(startingX);
//     }

// }