-- @block
CREATE TABLE Users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    bio TEXT,
    country VARCHAR(2)
);

-- @block
INSERT INTO Users (email, bio, country)
VALUES (
    'hello@world.com',
    'i love food',
    'US'
);
-- @block
INSERT INTO Users (email, bio, country)
VALUES
    ('hola@munda.com', 'bar', 'MX'),
    ('bonjour@monde.com', 'baz', 'FR');

-- @block
SELECT email, id FROM Users

WHERE country = 'US'
AND email LIKE 'h%'

ORDER BY id DESC
LIMIT 2;

-- @block
CREATE INDEX email_index ON Users(email);

-- @block
CREATE TABLE Rooms(
    id INT AUTO_INCREMENT,
    street VARCHAR(255),
    owner_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES Users(id)
);

-- @block
INSERT INTO Rooms(owner_id, street)
VALUES  
    (1, 'san diego sailboat'),
    (1, 'nantucket cottage'),
    (1, 'vail cabin'),
    (1, 'sf cardboard box');

-- @block
SELECT 
    Users.id as user_id,
    Rooms.id as room_id,
    email,
    street
FROM Users
LEFT JOIN Rooms
ON Rooms.owner_id = Users.id;

-- @block
CREATE TABLE Bookings(
    id INT AUTO_INCREMENT,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (guest_id) REFERENCES Users(id),
    FOREIGN KEY (room_id) REFERENCES Rooms(id)
);

-- @block rooms a user has booked
SELECT
    guest_id,
    street,
    check_in
FROM Bookings
INNER JOIN ROOMS ON Rooms.owner_id = guest_id