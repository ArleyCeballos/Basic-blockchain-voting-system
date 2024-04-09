// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ContratoVotacion {
    struct Propuesta {
        string nombre; // Nombre de la propuesta
        uint256 cantidadVotos; // Cantidad de votos recibidos por la propuesta
    }
        


    mapping(address => bool) private listaBlanca; // Mapeo de direcciones permitidas para realizar acciones
    mapping(address => bool) private haVotado; // Mapeo de direcciones que han votado
    Propuesta[] private propuestas; // Arreglo de propuestas
    uint256 private tiempoDespliegue; // Tiempo de despliegue del contrato
    address private propietario; // Dirección del dueño del contrato
    uint256 private longitudTotalListaBlanca=0; //Contador para saber cuantas adress estan en la lista blanca(activos o no)
    uint256 public longitudActivosListaBlanca=0; //Contador para saber cuantas adress estan activos en la lista blanca



    constructor() {
        tiempoDespliegue = block.timestamp; // Establece el tiempo de despliegue como el momento actual
        propietario = msg.sender; // Establece la dirección del creador del contrato como el dueño
    }



    modifier soloPropietario() {
        require(msg.sender == propietario, "Solo el propietario del contrato puede realizar esta accion"); // Verifica si la dirección del mensaje coincide con la dirección del dueño
        _;
    }

    modifier soloEnListaBlanca() {
        require(listaBlanca[msg.sender], "Solo las direcciones en lista blanca pueden realizar esta accion"); // Verifica si la dirección esta en la lista blanca
        _;
    }

    modifier soloDurantePeriodoVotacion() {
        require(block.timestamp <= tiempoDespliegue + 3 days, "El periodo de votacion ha terminado"); // Verifica si el período de votación ha terminado
        _;
    }
    


    function agregarPropuesta(string memory _nombre) public soloPropietario soloDurantePeriodoVotacion {
        propuestas.push(Propuesta(_nombre, 0)); // Agrega una nueva propuesta al arreglo de propuestas
    }

    function votar(uint256 _indicePropuesta) public soloEnListaBlanca soloDurantePeriodoVotacion {
        require(!haVotado[msg.sender], "Ya has votado, no puedes volver a votar"); // Verifica si la dirección ya ha votado
        require(_indicePropuesta < propuestas.length, "La propuesta no esta en la lista"); // Verifica si el índice de la propuesta es válido

        propuestas[_indicePropuesta].cantidadVotos++; // Incrementa la cantidad de votos de la propuesta seleccionada
        haVotado[msg.sender] = true; // Marca la dirección como que ha votado
    }

    function agregarAListaBlanca(address _direccion) public soloPropietario {
        require(!listaBlanca[_direccion],"La direccion ya esta en la lista Blanca"); // verifica que la dirección no este en la lista
        listaBlanca[_direccion] = true; // Agrega una dirección a la lista blanca
        longitudTotalListaBlanca++; // Le suma uno al contador del mapping
        longitudActivosListaBlanca++;

    }

    function eliminarDeListaBlanca(address _direccion) public soloPropietario {
        require(listaBlanca[_direccion],"La direccion No esta en la lista Blanca"); // verifica que la dirección no este en la lista
        listaBlanca[_direccion] = false; // Elimina una dirección de la lista blanca
        longitudActivosListaBlanca--;
    }

    function obtenerCantidadPropuestas() public view returns (uint256) {
        return propuestas.length; // Devuelve la cantidad de propuestas en el arreglo
    }

    function obtenerPropuesta(uint256 _indice) public view returns (string memory, uint256) {
        require(_indice < propuestas.length+1 && _indice>0 , "La propuesta no esta en la lista"); // Verifica si el índice de la propuesta es válido

        Propuesta memory propuesta = propuestas[_indice-1]; // Obtiene la propuesta en el índice especificado
        return (propuesta.nombre, propuesta.cantidadVotos); // Devuelve el nombre y la cantidad de votos de la propuesta
    }

    function estaEnListaBlanca(address _direccion) public view returns (bool) {
        return listaBlanca[_direccion]; // Verifica si una dirección está en la lista blanca
    }

    function yaVotaron(address _direccion) public view returns (bool) {
        return haVotado[_direccion]; // Verifica si una dirección ha votado
    }

  
    function haTerminadoPeriodoVotacion() public view returns (bool) {
        return block.timestamp > tiempoDespliegue + 3 days; // Verifica si el período de votación ha terminado
    }

    function todasLasPropuestas() public view returns (Propuesta[] memory) {
    return propuestas;
    }

    function transferirPropiedad(address nuevaDireccionPropietario) public soloPropietario {
    propietario = nuevaDireccionPropietario;
}

    
}