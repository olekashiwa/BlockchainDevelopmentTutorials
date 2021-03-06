// Указываем версию для компилятора
pragma solidity ^0.4.11;


// Контракт для установки прав


    // Переменная для хранения владельца контракта

    // Переменная для хранения адреса ДАО


    // Конструктор контракта, который задаёт владельца контракта с помощью аккаунта отправителя



    // Модификатор, который выбрасывает ошибку, если вызвана любым аккаунтом, кроме владельца.




     // Модификатор, который выбрасывает ошибку, если вызвана любым аккаунтом, кроме ДАО.



     // Функция которая позволяет текущему владельцу перевести контроль над контрактом новому владельцу.



    // Фукнция для установки нового контракта ДАО


// Контракт для остановке некоторых операций

    // Переменная для хранения состояния

    // Модификатор

    // Функция для установки переменной в состояние остановки

    // Функция для установки переменной в состояние работы


// Инициализация контракта
contract DAOToken is Stoppable, OwnableWithDAO{

    // Объявляем переменную в которой будет название токена
    string public name;
    // Объявляем переменную в которой будет символ токена
    string public symbol;
    // Объявляем переменную в которой будет число нулей токена
    uint8 public decimals;

    // Объявляем переменную в которой будет храниться общее число токенов
    uint256 public totalSupply;

    // Объявляем маппинг для хранения балансов пользователей
    mapping (address => uint256) public balanceOf;
    // Объявляем маппинг для хранения одобренных транзакций
    mapping (address => mapping (address => uint256)) public allowance;

    // Объявляем эвент для логгирования события перевода токенов
    event Transfer(address from, address to, uint256 value);
    // Объявляем эвент для логгирования события одобрения перевода токенов
    event Approval(address from, address to, uint256 value);


    // Функция инициализации контракта
    function DAOToken(){
        // Указываем число нулей
        decimals = 0;
        // Объявляем общее число токенов, которое будет создано при инициализации
        totalSupply = 10 * (10 ** uint256(decimals));
        // 10000000 * (10^decimals)

        // "Отправляем" все токены на баланс того, кто инициализировал создание контракта токена
        balanceOf[msg.sender] = totalSupply;

        // Указываем название токена
        name = "DAOCoin";
        // Указываем символ токена
        symbol = "DAO";
    }

    // Внутренняя функция для перевода токенов
    function _transfer(address _from, address _to, uint256 _value) stoppable internal {
        require(_to != 0x0);
        // Проверка на пустой адрес
        require(balanceOf[_from] >= _value);
        // Проверка того, что отправителю хватает токенов для перевода
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        //

        balanceOf[_to] += _value;
        // Токены списываются у отправителя
        balanceOf[_from] -= _value;
        // Токены прибавляются получателю

        Transfer(_from, _to, _value);
        // Перевод токенов
    }

    // Функция для перевода токенов
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
        // Вызов внутренней функции перевода
    }

    // Функция для перевода "одобренных" токенов
    function transferFrom(address _from, address _to, uint256 _value) public {
        // Проверка, что токены были выделены аккаунтом _from для аккаунта _to
        require(_value <= allowance[_from][_to]);
        allowance[_from][_to] -= _value;
        // Отправка токенов
        _transfer(_from, _to, _value);
    }

    // Функция для "одобрения" перевода токенов
    function approve(address _to, uint256 _value) public {
        allowance[msg.sender][_to] = _value;
        Approval(msg.sender, _to, _value);
        // Вызов эвента для логгирования события одобрения перевода токенов
    }


    // DAO функция для установки имени


}