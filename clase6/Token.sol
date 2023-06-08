// SPDX-License-Identifier:MIT
pragma solidity ^0.8.5;

/* 
Esto es un smart contract de un token ERC20 que incluye un contrato legal grabado e imposible de modificar para adjudicarle
derechos a cada uno de esos tokens. Obviamente esto está hecho a nivel conceptual y no quiere decir que sea la verdadera
implementación legal al asunto de tokenización ni la tecnologica ya que hay muchas otras cosas que contemplar.

Hecho el deploy en la red mumbai en: 0xAA2270167d5d655213776272c379dc645D6e0d7c
*/
contract myToken
{ 
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    string public contrato="Este Contrato de Token de Tenencia es para confirmar que la posesion de este Token es para representar el 100% de acciones de una LLC. Solo se emitiran 100 tokens y todos los derechos, beneficios y responsabilidades seran igualmente repartidos entre los poseedores de los tokens.";

    constructor(string memory _name,string memory _symbol, uint256 _totalSupply, uint8 _decimals)
    {
        name=_name;//_name;
        symbol=_symbol;//_symbol;
        decimals=_decimals;//_decimals;
        totalSupply=_totalSupply;
        balanceOf[msg.sender]=_totalSupply * (10 ** decimals);
    }

    function transfer(address _to, uint256 _value) public returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return(true);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
    {
        require(allowance[_from][msg.sender] >= _value);
        require(balanceOf[_from] >= _value);
        allowance[_from][msg.sender] -= _value;
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        return(true);
    }

    function approve(address _spender, uint256 _value) public returns (bool success)
    {
        allowance[msg.sender][_spender]=0;
        allowance[msg.sender][_spender]=_value;
        emit Approval(msg.sender, _spender, _value);
        return(true);
    }
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}