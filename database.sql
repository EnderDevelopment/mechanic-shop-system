CREATE TABLE IF NOT EXISTS mechanic_shop_vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plate VARCHAR(10) NOT NULL,
    owner VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    health INT NOT NULL,
    customization JSON NOT NULL
);

INSERT INTO mechanic_shop_vehicles (plate, owner, model, health, customization) VALUES
('ABC123', 'player1', 'adder', 1000, '{}');
INSERT INTO mechanic_shop_vehicles (plate, owner, model, health, customization) VALUES
('XYZ789', 'player2', 'sultan', 800, '{}');