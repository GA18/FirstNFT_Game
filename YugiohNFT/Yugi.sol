// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Yugioh is ERC721{

    struct Carta {
        string name;
        uint ATK;
        uint DEF;
        string img;
        uint vitorias;
    }

    Carta[] public cartas;
    address public gameOwner;

    constructor() ERC721 ("Yugioh", "YGO") {
        gameOwner = msg.sender;
    }

    modifier onlyOwnerOf(uint _monsterId) {
        require(ownerOf(_monsterId) == msg.sender, "Apenas o dono deste baralho pode duelar com ele");
        _;
    }

    function battle(uint _ATK, uint _DEF) public onlyOwnerOf(_ATK) {
        Carta storage battleATK = cartas[_ATK];
        Carta storage battleDEF = cartas[_DEF];

        if(battleATK.ATK >= battleDEF.DEF) {
            battleATK.vitorias += 1;
        } else {
            battleDEF.vitorias += 1;
        }
    }

    function createNewCard (string memory _name, uint _ATK, uint _DEF, string memory _img, uint _vitorias, address _to) public {
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novos Cards");
        uint id = cartas.length;
        cartas.push(Carta(_name, _ATK, _DEF, _img, _vitorias));
        _safeMint(_to, id);

    }
}