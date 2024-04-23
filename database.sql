-- Таблица для баланса пользователей
CREATE TABLE balance (
    id INTEGER AUTO_INCREMENT,
    chips DOUBLE,
    money DOUBLE,
    lastUpdated DATETIME,   
    PRIMARY KEY (id)
);

-- Таблица для игр
CREATE TABLE game (
    id INTEGER AUTO_INCREMENT,
    gameName VARCHAR(255),
    PRIMARY KEY (id)
);

-- Таблица для статистики игры
CREATE TABLE statistic (
    id INTEGER AUTO_INCREMENT,
    bet DOUBLE,
    result ENUM('win', 'lose', 'draw'),
    amount DOUBLE,
    playDate DATETIME,
    PRIMARY KEY (id)
);

-- Таблица для пользователей
CREATE TABLE user (
    id INTEGER AUTO_INCREMENT,
    username VARCHAR(255),
    password VARCHAR(255),
    email VARCHAR(255),
    role ENUM('admin', 'player'),
    balance_id INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (balance_id) REFERENCES balance(id)
);

-- Таблица для связи пользователей с играми и статистикой
CREATE TABLE statistic_to_player (
    user_id INTEGER,
    statistic_id INTEGER,
    game_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (statistic_id) REFERENCES statistic(id),
    FOREIGN KEY (game_id) REFERENCES game(id)
);

-- Таблица для транзакций
CREATE TABLE transaction (
    id INTEGER AUTO_INCREMENT,
    user_id INTEGER,
    amount DOUBLE,
    transaction_type ENUM('deposit', 'withdraw', 'internal'),
    transaction_date DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Таблица для промо-акций
CREATE TABLE promotion (
    id INTEGER AUTO_INCREMENT,
    promotion_name VARCHAR(255),
    promotion_description TEXT,
    start_date DATETIME,
    end_date DATETIME,
    PRIMARY KEY (id)
);

-- Таблица для связи пользователей с промо-акциями
CREATE TABLE user_promotion (
    user_id INTEGER,
    promotion_id INTEGER,
    PRIMARY KEY (user_id, promotion_id),
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (promotion_id) REFERENCES promotion(id)
);

-- Таблица для журнала транзакций
CREATE TABLE transaction_log (
    id INTEGER AUTO_INCREMENT,
    transaction_id INTEGER,
    user_id INTEGER,
    transaction_type ENUM('deposit', 'withdraw', 'internal'),
    amount DOUBLE,
    transaction_date DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (transaction_id) REFERENCES transaction(id),
    FOREIGN KEY (user_id) REFERENCES user(id)
);