// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Owners {    

    struct House {
        uint256 houseId; //Identificador
        string seller; //Nombre Dueño
        string state;  //estado
        string street; //Direccion de la propiedad
        uint precio;  
        uint256 rooms; 
        bool isAvailable; //Marcar si esta vendida o no 
        address payable vendedor;
    }

    event HouseEvent (
        uint256 houseId,
        string seller,
        string state,
        string street,
        uint precio, 
        uint256 rooms,
        bool isAvailable,
        address payable vendedor
    );

    event HouseBuy (
        uint256 houseId,
        string seller,
        string state,
        string street,
        uint precio, 
        uint256 rooms,
        bool isAvailable,
        address payable vendedor
    );

    

    mapping(uint256 => House) public houses;
    uint256 public total=0;

  
    //Comprar casa
    function buy(uint256 _houseId) payable public{         
      require(_houseId >= 0 && _houseId < total); 
      House memory _house = houses[_houseId]; 
      address payable _vendedor = _house.vendedor; 
      
      //require(msg.value >= _house.precio);
       //La casa se puede comprar
       require(houses[_houseId].isAvailable == true);

       //Registramos la compra    
       houses[_houseId].isAvailable = false;
      
      //_vendedor.transfer(_house.precio);
      emit HouseBuy(total, _house.seller, _house.state, _house.street , _house.precio, _house.rooms, false, payable(msg.sender)); 
    }


    //Agregar nueva casa
    function addNewHouse(string memory _seller, string memory _state, string memory _street) public {
      uint _precio=200;
      uint256 _rooms=3;
      total++;
      houses[total]= House(total, _seller, _state, _street , _precio, _rooms, true, payable(msg.sender));
      emit HouseEvent(total, _seller, _state, _street , _precio, _rooms, true, payable(msg.sender));
        
    }


}
