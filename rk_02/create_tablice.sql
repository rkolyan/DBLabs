DROP TABLE IF EXISTS purchases CASCADE;
DROP TABLE IF EXISTS buckets CASCADE;
DROP TABLE IF EXISTS buyers CASCADE;
DROP TABLE IF EXISTS florists CASCADE;

CREATE TABLE florists
(
	florist_id INT NOT NULL PRIMARY KEY,
	fio VARCHAR(300),
	passport_number INT,
	telephone BIGINT
);

CREATE TABLE buyers
(
	buyer_id INT NOT NULL PRIMARY KEY,
	fio VARCHAR(300),
	birthdate date,
	city VARCHAR(100),
	telephone BIGINT
);

CREATE TABLE buckets
(
	bucket_id INT NOT NULL PRIMARY KEY,
	florist_id INT NOT NULL REFERENCES florists(florist_id),
	name VARCHAR(100)
);

CREATE TABLE purchases
(
	purchase_id INT NOT NULL PRIMARY KEY,
	buyer_id INT NOT NULL REFERENCES buyers(buyer_id),
	florist_id INT NOT NULL REFERENCES florists(florist_id),
	bucket_id INT NOT NULL REFERENCES buckets(bucket_id)
);
