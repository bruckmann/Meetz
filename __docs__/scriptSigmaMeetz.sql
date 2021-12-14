
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  role VARCHAR(4),
  name VARCHAR(20),
  password VARCHAR(10),
  email VARCHAR(150)
);

CREATE TABLE room_localizations (
  id SERIAL PRIMARY KEY,
  floor VARCHAR(50),
  number VARCHAR(5)
);

CREATE TABLE room_specifications (
  id SERIAL PRIMARY KEY,
  name VARCHAR(20),
  decription TEXT,
  max_person INTEGER,
  has_data_show BOOLEAN,
  has_board BOOLEAN,
  has_split BOOLEAN,
  size VARCHAR(10)
);

CREATE TABLE images (
  id SERIAL PRIMARY KEY
  room_specification_id INTEGER,
  image_uri TEXT
  FOREIGN KEY(room_specification_id)
    REFERENCES room_specifications(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE meeting_rooms (
  id SERIAL PRIMARY KEY,
  room_localization_id INTEGER,
  room_specification_id
  FOREIGN KEY(room_specification_id)
    REFERENCES room_specifications(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
  FOREIGN KEY(room_localization_id)
    REFERENCES room_specifications(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE appointments (
  id SERIAL PRIMARY KEY,
  meeting_room_id INTEGER,
  user_id INTEGER,
  initial_date TIMESTAMPTZ,
  end_date TIMESTAMPTZ,
  note TEXT,
  FOREIGN KEY(meeting_room_id)
    REFERENCES meeting_rooms(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
  FOREIGN KEY(user_id)
    REFERENCES users(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE

);
