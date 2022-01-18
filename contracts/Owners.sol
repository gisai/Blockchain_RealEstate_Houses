// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Owners {    

    struct House {
        uint256 houseId; //Identificador
        string seller; //Nombre Dueño
        string state;  //estado
        string street; //Direccion de la propiedad
        uint256 precio;  
        uint256 rooms; 
        bool isAvailable; //Marcar si esta vendida o no 
        //address payable owner;
    }

    event HouseEvent (
        uint256 houseId,
        string seller,
        string state,
        string street,
        uint256 precio, 
        uint256 rooms,
        bool isAvailable
    );

    event HouseBuy (
        uint256 houseId,
        string seller,
        string state,
        string street,
        uint256 precio, 
        uint256 rooms,
        bool isAvailable
    );

    

    mapping(uint256 => House) public houses;
    uint256 public total=0;

  
    //Comprar casa
    function buy(uint256 _houseId) public{         
      require(_houseId >= 0 && _houseId < total); 
      House memory _house = houses[_houseId]; 
      //address payable _vendedor = _house.owner; 
      
    
       //La casa se puede comprar
       require(houses[_houseId].isAvailable == true);

       //Registramos la compra    
       houses[_houseId].isAvailable = false;
      //payable(msg.sender)
      emit HouseBuy(total, _house.seller, _house.state, _house.street , _house.precio, _house.rooms, false); 
    }


    //Agregar nueva casa
    function addNewHouse(string memory _seller, string memory _state, string memory _street) public {
      uint256 _precio=(total+1)*10;
      uint256 _rooms=3;
      total++;
      houses[total]= House(total, _seller, _state, _street , _precio, _rooms, true);
      emit HouseEvent(total, _seller, _state, _street , _precio, _rooms, true);
        
    }


}