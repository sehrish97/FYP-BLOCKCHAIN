// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract FoodOrder {
    struct Order {
        uint256 price;
        uint256 quantity;
        string dishName;
        string description;
        bool confirmed;
        bool delivered;
        address restaurant;
    }

    mapping (uint256 => Order) public orders;
    uint256 public orderCount;

    function placeOrder(string memory _dishName, uint256 _price, uint256 _quantity, string memory _description) public {
        orderCount++;
        orders[orderCount] = Order({
            price: _price,
            quantity: _quantity,
            dishName: _dishName,
            description: _description,
            confirmed: false,
            delivered: false,
            restaurant: address(0)
        });
    }

    function confirmOrder(uint256 _orderId) public {
        require(orders[_orderId].confirmed == false, "Order already confirmed.");
        orders[_orderId].confirmed = true;
    }

    function setRestaurant(uint256 _orderId, address _restaurant) public {
        require(orders[_orderId].confirmed == true, "Order not confirmed.");
        require(orders[_orderId].delivered == false, "Order already delivered.");
        orders[_orderId].restaurant = _restaurant;
    }

    function deliverOrder(uint256 _orderId) public {
        require(orders[_orderId].restaurant == msg.sender, "Unauthorized access.");
        orders[_orderId].delivered = true;
    }
}
