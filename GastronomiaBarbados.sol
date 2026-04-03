// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaBarbados
 * @dev Registro historico con Likes, Dislikes e Identificador de Grano de Cou-Cou.
 * Nota: Codigo ASCII puro (sin enies ni acentos) para maxima compatibilidad.
 */
contract GastronomiaBarbados {

    struct Plato {
        string nombre;
        string descripcion;
        string granoCouCou; 
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // "acompanado" en lugar de "acompañado" para evitar ParserError
        registrarPlato(
            "Flying Fish and Cou-Cou", 
            "Pez volador sazonado acompanado de una mezcla cremosa de harina de maiz y okra.",
            "Fino"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _granoCouCou
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            granoCouCou: _granoCouCou,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory granoCouCou,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.granoCouCou, p.likes, p.dislikes);
    }
}
