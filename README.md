# Contrato de Votación basico en Blockchain

Este es un contrato inteligente desarrollado en Solidity mediante REMIX IDE que permite realizar votaciones utilizando una lista blanca de direcciones permitidas y un período de votación limitado. Este contrato ha sido desplegado en la red Ethereum y puede ser interactuado a través de una interfaz de usuario compatible con contratos inteligentes como MetaMask.

## Estructura del Contrato

### Estructura de Datos

- `Propuesta`: Una estructura que contiene el nombre de la propuesta y la cantidad de votos recibidos.
- `listaBlanca`: Un mapping que mapea direcciones a booleanos para determinar si una dirección está permitida para realizar acciones.
- `haVotado`: Un mapping que mapea Etherium address a booleanos para determinar si una address ha votado.
- `propuestas`: Un arreglo de estructuras `Propuesta`.
- `tiempoDespliegue`: Una variable que almacena el tiempo de despliegue del contrato.
- `propietario`: Una variable que almacena la dirección del propietario del contrato.
- `longitudTotalListaBlanca`: Un contador para saber cuántas direcciones están en la lista blanca (activas o no).
- `longitudActivosListaBlanca`: Un contador para saber cuántas direcciones están activas en la lista blanca.

### Modificadores

- `soloPropietario`: Verifica si el mensaje proviene del propietario del contrato.
- `soloEnListaBlanca`: Verifica si la address está en la lista blanca.
- `soloDurantePeriodoVotacion`: Verifica si el período de votación no ha terminado.

### Funcionalidades Principales

- `agregarPropuesta(_nombre)`: Permite al propietario agregar una nueva propuesta al arreglo de propuestas.
- `votar(_indicePropuesta)`: Permite a las address en la lista blanca votar por una propuesta.
- `agregarAListaBlanca(_direccion)`: Permite al propietario agregar una address a la lista blanca.
- `eliminarDeListaBlanca(_direccion)`: Permite al propietario eliminar una address de la lista blanca.
- `transferirPropiedad(_nuevaDireccionPropietario)`: Permite al propietario transferir la propiedad del contrato a otra address.

### Consultas

- `obtenerCantidadPropuestas()`: Devuelve la cantidad de propuestas en el arreglo.
- `obtenerPropuesta(_indice)`: Devuelve el nombre y la cantidad de votos de una propuesta específica.
- `estaEnListaBlanca(_direccion)`: Verifica si una address está en la lista blanca.
- `yaVotaron(_direccion)`: Verifica si una address ha votado.
- `haTerminadoPeriodoVotacion()`: Verifica si el período de votación ha terminado.
- `todasLasPropuestas()`: Devuelve todas las propuestas en el arreglo.

## Uso

Para interactuar con el contrato, se pueden utilizar las funciones mencionadas anteriormente a través de una interfaz de usuario compatible con contratos inteligentes como MetaMask. Es importante tener en cuenta que algunas funciones están restringidas al propietario del contrato o a las direcciones en la lista blanca, y que el período de votación tiene una duración máxima de 3 días.

## Dirección en la Red Ethereum

La dirección del contrato en la red Sepolia Ethereum es [esta.](https://sepolia.etherscan.io/tx/0xae448b6ce8827985321194971f70f8c9a562941a33f327b2c5803f42badf9c48).

---

Este contrato ha sido desarrollado como parte de un ejercicio de aprendizaje de Solidity y puede requerir ajustes adicionales para su implementación en un entorno de producción.
