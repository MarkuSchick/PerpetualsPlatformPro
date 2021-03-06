// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3XAU {
    AggregatorV3Interface internal priceFeed_xau_usd;

    /* Network: Kovan
     * Aggregator: XAU/USD
     * Address: 0xc8fb5684f2707C82f28595dEaC017Bfdf44EE9c5
     */
    /* Network: Rinkeby
     * Aggregator: XAU/USD
     * Address: 0x81570059A0cb83888f1459Ec66Aad1Ac16730243
     */
    constructor() {
        priceFeed_xau_usd = AggregatorV3Interface(
            0x81570059A0cb83888f1459Ec66Aad1Ac16730243
        );
    }

    /**
     * Returns the latest price
     */
    function getXAUPrice() public view returns (int256) {
        (, int256 price, , uint256 timeStamp, ) =
            priceFeed_xau_usd.latestRoundData();
        // If the round is not complete yet, timestamp is 0
        require(timeStamp > 0, "Round not complete");
        return price;
        //return 1900 * 10**8;
    }
}

contract DerivedPriceOracle is PriceConsumerV3XAU {
    constructor() PriceConsumerV3XAU() {}
}
