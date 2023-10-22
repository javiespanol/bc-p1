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

    event NuevoProducto(uint ArrayProductoId, string nombre, uint id);

    function _crearProducto(string memory _nombre, uint _id) private {
        productos.push(Producto(_nombre, _id));
        
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

    function Propiedad(uint _id) public {
        productoAPropietario[_id] = msg.sender;
        propietarioProductos[msg.sender]++;
    }

    function getProductosPorPropietario(address _propietario) external view returns (uint[] memory){
        uint contador = 0;
        uint[] memory resultado = new uint[](propietarioProductos[_propietario]);

        for (uint i=0; i<productos.length; i++) 
        {
            if (_propietario==productoAPropietario[i]) {
                
                //Aquí hay 2 posibilidades. Meter el ID del producto, o el ID del array del producto
                //Si es el ID propio del producto.
                //resultado[contador] = productos[i].identificacion;

                //Si es el ID del array del producto.
                resultado[contador] = productos[i].identificacion;
                contador++;
            }
        }
        return resultado;
    }
}