// Указываем версию солидити для компилятора
pragma solidity ^0.4.11;

contract MyToken {

    // Создаем mapping - ассоциативный массив, в котором ключом будет адрес, а значением - баланс
    mapping (address => uint256) public balanceOf;

    // Функция для инициализации контракта
    function MyToken(
        // Указываем сколько токенов мы создадим
        // Это значение будет передаваться при инициализации токена
        uint256 initialSupply
        ) {

        // Создаем все токены на кошельке того, кто создал токен
        balanceOf[msg.sender] = initialSupply;
    }

    // Функция для отправки токенов
    // Фукнция принимает адрес того, кому нужно отправить токены
    // и число токенов, которое мы хотим отправить
    function transfer(address _to, uint256 _value) public {
        // Проверяем хватает ли токенов у того, кто хочет их отправить
        require(balanceOf[msg.sender] >= _value);
        // Проверяем, не произошло ли переполнение
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        // Забираем токены у того, кто их отправил
        balanceOf[msg.sender] -= _value;
        // Передаем токены тому, кому мы их отправили
        balanceOf[_to] += _value;
    }
}