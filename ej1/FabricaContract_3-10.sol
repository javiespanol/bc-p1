//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract FabricaContract {
    
    uint idDigits = 16;
    struct Producto {
        string nombre;
        uint identificacion;
    }

    Producto[] public productos;

    mapping (uint => address) public productoAPropietario;
    mapping (address => uint) public propietarioProductos;



    function _crearProducto(string memory _nombre, uint _id) private {
        Producto memory p;
        p.nombre = _nombre;
        p.identificacion = _id;
        productos.push(p);
        
        emit NuevoProducto(productos.length-1, _nombre, _id);
    }

    

    function _generarAleatorio(string memory _str) private view returns (uint){
        
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        uint idModulus = 10^idDigits;
        return rand % idModulus;

    }

    function crearProductoAleatorio(string memory _nombre) public {
        uint randId = _generarAleatorio(_nombre);
        _crearProducto(_nombre, randId);
    }

    event NuevoProducto(uint ArrayProductoId, string nombre, uint id);

    function Propiedad(uint _id) public {
        productoAPropietario[_id] = msg.sender;
        propietarioProductos[msg.sender]++;
    }

    function getProductosPorPropietario(address _propietario) external view returns (uint[] memory){
        uint contador = 0;
        uint[] memory resultado;

        for (uint i=0; i<productos.length; i++) 
        {
            if (_propietario==productoAPropietario[productos[i].identificacion]) {
                resultado[contador] = productos[i].identificacion;
                contador++;
            }
        }

        return resultado;
    }

}