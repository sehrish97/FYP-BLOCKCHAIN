pragma solidity ^0.8.0;

contract FoodOrder {
    // Define a struct for food items
    struct FoodItem {
        uint itemId;
        uint quantity;
        string description;
        string category;
        uint price;
    }

    // Define a mapping to store food items
    mapping (uint => FoodItem) public foodItems;
    uint public foodItemCount;

    // Define a struct for orders
    struct Order {
        uint orderId;
        uint itemId;
        uint quantity;
        uint totalPrice;
        address customer;
        string type;
    }

    // Define a mapping to store orders
    mapping (uint => Order) public orders;
    uint public orderCount;

    // Function to add a food item
    function addFoodItem(uint _itemId, uint _quantity, string memory _description, string memory _category, uint _price) public {
        foodItemCount++;
        foodItems[foodItemCount] = FoodItem(_itemId, _quantity, _description, _category, _price);
    }

    // Function to place an order
    function placeOrder(uint _itemId, uint _quantity, string memory _type) public {
        Order memory order = Order(orderCount, _itemId, _quantity, _quantity * foodItems[_itemId].price, msg.sender, _type);
        orderCount++;
        orders[orderCount] = order;
    }

    // Function to get a food item
    function getFoodItem(uint _itemId) public view returns (uint, uint, string memory, string memory, uint) {
        return (foodItems[_itemId].itemId, foodItems[_itemId].quantity, foodItems[_itemId].description, foodItems[_itemId].category, foodItems[_itemId].price);
    }

    // Function to get an order
    function getOrder(uint _orderId) public view returns (uint, uint, uint, uint, address, string memory) {
        return (orders[_orderId].orderId, orders[_orderId].itemId, orders[_orderId].quantity, orders[_orderId].totalPrice, orders[_orderId].customer, orders[_orderId].type);
    }
}
