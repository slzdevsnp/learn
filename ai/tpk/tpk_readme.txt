schedule

pyalgo ch01  OK




=========
#pyalgo
=========
ch01

py trading packages
PyAlgoTrade
Zipline (backtesting , quantopian uses it

vendor packages
quandl
eikon (refinitiv)
bloomberg
oanda
interactive brokers



=========
#py4fi
=========

=========
#finpy
=========


=========
#blackbox
=========

CHAP 02
	quant strategy parts
	
	alpha mdodel + risk model + transaction model  
	-->  portfolio transaction model
	<--
	-->  execution model


CHAP 03 
alpha sources
	1. price
		trend
		reversion
		technical sentiment
	2. fundamental
		yield
		growth
		quality

trend and mean reversion can both be successfull because employed on different
time scales  eg. SPX between 2000-2018


techincal sentiment examples
	1. look at options market to understand the underlying (e.g. puts/calls ratio
	2. trading volume, open inteterest as an indicator 
	3. for HFT evaluate a shape of limit order book for near-term sentiment
		e.g. size of bids away from mid vs size of best bid  or sum(bid)/sum(ask)

quantitative fundamental strategies based on fundamenatal alpha sources
	Fama-French papers  (cross-section of expected returns
	Vaue/yield  ratios  of fundamental factor / price  i.e. P/E ratio == earnigns yield,
	divident yield. quants use E/P   earnings / price  for a better math behavior
	
	carry trade = sell security with high yield and use proceeds to buy security with 
	lower yield . gain yield difference. popular with quants in currencies
	in FX buy ccy with higher short term yeidl , sell ccy with lower short term yield.
	this provies a safety. if the trade does not work, the loss is minus the yield diff.
	e.g. buy eur sell usd trade.
	similar strategies used in trading bonds
	Higher yield also means a more risky instrument i.e. a bond with lower rating  

	in equities EBITDA/EV (ev = enterprise value) or book value to price
	=> QLS (quant long/short) strategies .  ranking stocks

	in futures roll yield.   spread between future contract vs near contract
	spread > 0 contango, spread < 0 backwardation

	growth sentiment:  PEG price/earnigns-to-growth

	Quuality strats  (flight-to-quality  behaviour)
		leverage:   debt-to-equity ratios
		diversity of revenue sources,  special case: volatility of revenues
		management quality
		fraud risk  for companies or countries  case: earnings quality signal 
					delta between reported and true economic earnings
		
		quality of the issuer of an instrument
	CDS markets recently provided more regulary available quality-sentiment data
        quality signals works rarely consistently, mostly when things for a company are
	really bad and general market is not trending up

	!! Data driven alpha models
	less common, more tehnically and math challenging
	trading strategies with time horizons of minues or less

	Time Horizons
	HFT strats forecast up to end of day
	Short-term strats hold position 1 day to two weeks
	Medium-term strats forecast few weeks to few months
	Long-term strats hold positions several months or longer

	bets structure
		forecast instrument, or instrument relative to other. i.e. relative forecasts
		behavior of small clusters (pairs) vs large clusters (sectors)
		most quants who trade in groups tend  to use larger groups then simply pairs when
		they make relative bets
	how to define group:  use statistical techniques, use heuristics (e.g. fundamentally defined industry groups)
	heuristic group suffer from ridigity. Most groupig techniques suffer from market regime changes

	investment universe: (prefer liquidity with abundandance of high quality historic data)
	geography, asset class, instrument class 
	quants end with common stocks, fuures (especially on bonds and equity indices) and FX markets
	quants are less present in OTC instruments and emerging markets, nearly completely absent from illiquid instrs

	refitting model == recalibration.  danger of overfitting

	conditioning variables
	e.g. stop-loss, profit-target(profit-stops)  time stops

	secondary conditioner: set of rules to trigger a position entry e.g. on up trending market buy on dips 
		sell on ups on down trending market

	model run frequency:  in RT(transaction costs) vs once per month (market impact of large trades)

	blending alpha models
		via linear model, non-linear model, machine learning, do not blend

CHAP 4  Risk models

CHAP 5 Transaction Cost models





