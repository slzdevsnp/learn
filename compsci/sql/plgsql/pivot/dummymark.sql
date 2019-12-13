
drop table if exists dummymark;

CREATE TABLE IF NOT EXISTS dummymark(
	symbol text,
	LP     text,
	y0   double precision,
	y100  double precision,
	y1000 double precision
);


COPY dummymark(symbol, LP, y0, y100, y1000) from stdin;
EUR/USD	009	0.0001	0.0002	0.0003
EUR/USD	019	-0.0001	-0.0002	-0.0003
EUR/USD	009	0.0002	0.0003	0.0004
EUR/USD	019	-0.0002	-0.0003	-0.0004
\.


