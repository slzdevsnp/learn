
drop table if exists ardummymark;

CREATE TABLE IF NOT EXISTS ardummymark(
	symbol text,
	LP     text,
	markouts  double precision []
);

INSERT INTO ardummymark(symbol,lp,markouts)VALUES('EUR/USD','009',ARRAY[0.0001, 0.0002, 0.0003]);
INSERT INTO ardummymark(symbol,lp,markouts)VALUES('EUR/USD','019',ARRAY[-0.0001, -0.0002, -0.0003]);
INSERT INTO ardummymark(symbol,lp,markouts)VALUES('EUR/USD','009',ARRAY[0.0002,  0.0003,  0.0004]);
INSERT INTO ardummymark(symbol,lp,markouts)VALUES('EUR/USD','019',ARRAY[-0.0002, -0.0003, -0.0004]);

