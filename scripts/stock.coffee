# Description:
#   Get a info
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot stock [info|quote|price] [for|me] <ticker> [1d|5d|2w|1mon|1y] - Get a stock price
#   hubot chartotc_d <ticker> - Get a chart from stockcharts.com
#   hubot chart_oil - Crude Oil WTI 5m Futures Graph
#   hubot chart_gold - Gold Futures
#   hubot chart_gas - Natural Gas Futures
#   hubot chart_dow - Dow Jones Index chart
#   hubot chart_sp500 - S&P 500 Index Chart
#   hubot chart_nasdaq - Nasdaq Index Chart
#   hubot chart_eurusd - 5m EUR/USD Forex Chart
#   hubot sector_d - Sector Performance 1 Day
#   hubot sector_w - Sector Performance 1 Week
#   hubot sector_1m - Sector Performance 1 Month
#   hubot sector_3m - Sector Performance 3 Month
#   hubot sector_6m - Sector Performance 6 Month
#   hubot sector_y - Sector Performance 1 Year
#   hubot sector_ytd - Sector Performance Year to Date
#   hubot new_highs - Top 20 stocks making New 52 Week Highs Today
#   hubot top_gainers - The Top 20 Gainers today
#   hubot upgrades - Top 20 stocks with new Upgrades
#   hubot overbought - Top 20 stocks that are overbought
#   hubot unusualvol - Top 20 stocks with Unusual Volume
#   hubot volatile - Top 20 Most Volatile Stocks
#   hubot oversold - Top Most Oversold Stocks
#   hubot new_lows - Top 20 stocks making New 52 Week Lows
#   hubot most_active - Top 20 stocks that are most active today
#
# Author:
# som3guy

module.exports = (robot) ->
  robot.respond /stock (?:info|price|quote)?\s?(?:for|me)?\s?@?([A-Za-z0-9.-_]+)\s?(\d+\w+)?/i, (msg) ->
    ticker = escape(msg.match[1])
    time = msg.match[2] || '1d'
    msg.http('http://finance.google.com/finance/info?client=ig&q=' + ticker)
      .get() (err, res, body) ->
        result = JSON.parse(body.replace(/\/\/ /, ''))
        msg.send "http://chart.finance.yahoo.com/z?s=#{ticker}&t=#{time}&q=l&l=on&z=l&a=v&p=s&lang=en-US&region=US#.png"
        msg.send result[0].l_cur + "(#{result[0].c})"

# OTC Charts
  robot.respond /chartotc_d (.*)$/i, (msg) ->
    ticker = msg.match[1]
    msg.send "http://stockcharts.com/c-sc/sc?chart=#{ticker},uu[700,a]daclyyay[pb50!b200!f][vc60][iue12,26,9!lc20]"

# Charts for Futures
#
# Chart oil
  robot.respond /chart_oil/i, (msg) ->
    msg.send "http://finviz.com/fut_chart.ashx?t=CL&cot=067651&.png"

# Chart gold
  robot.respond /chart_gold/i, (msg) ->
    msg.send "http://finviz.com/fut_chart.ashx?t=GC&cot=088691&.png"

# Chart natural gas
  robot.respond /chart_gas/i, (msg) ->
    msg.send "http://finviz.com/fut_chart.ashx?t=NG&cot=023651&.png"

# Chart Dow Jones
  robot.respond /chart_dow/i, (msg) ->
    msg.send "http://finviz.com/fut_chart.ashx?t=YM&cot=124601&.png"

# Chart S&P 500
  robot.respond /chart_sp500/i, (msg) ->
    msg.send "http://finviz.com/fut_chart.ashx?t=ES&cot=138741&.png"

# Chart Nasdaq
  robot.respond /chart_nasdaq/i, (msg) ->
    msg.send "http://finviz.com/fut_chart.ashx?t=NQ&cot=209741&.png"

# Chart USD/EUR
  robot.respond /chart_eurusd/i, (msg) ->
    msg.send "http://finviz.com/fx_image.ashx?eurusd_d1_l.png"

# Charts for sector performance
#
# Sector performance 1 day
  robot.respond /sector_d/i, (msg) ->
    msg.send "http://finviz.com/grp_image.ashx?bar_sector_t.png"

# Sector performance 1 week
  robot.respond /sector_w/i, (msg) ->
    msg.send "http://finviz.com/grp_image.ashx?bar_sector_w.png"

# Sector performance 1 month
  robot.respond /sector_1m/i, (msg) ->
    msg.send "http://finviz.com/grp_image.ashx?bar_sector_m.png"

# Sector performance 3 months
  robot.respond /sector_3m/i, (msg) ->
    msg.send "http://finviz.com/grp_image.ashx?bar_sector_q.png"

# Sector performance 6 months
  robot.respond /sector_6m/i, (msg) ->
    msg.send "http://finviz.com/grp_image.ashx?bar_sector_h.png"

# Sector performance 1 year
  robot.respond /(sector_y$)/i, (msg) ->
    msg.send "http://finviz.com/grp_image.ashx?bar_sector_y.png"

# Sector performance year to date
  robot.respond /sector_ytd/i, (msg) ->
    msg.send "http://finviz.com/grp_image.ashx?bar_sector_ytd.png"

# Top 20 stocks making New 52 Week Highs Today
  robot.respond /new_highs/i, (msg) ->
    cp = require "child_process"
    cp.exec "/opt/bender/helper_scripts/finviz.rb new_highs", (error, stdout, stderr) ->
      if error
            msg.send "Sorry I encounted this error \n" + stderr
        else
            msg.send "Top 20 stocks making New 52 Week Highs Today are:\n" + stdout

# The Top 20 Gainers today
  robot.respond /top_gainers/i, (msg) ->
    cp = require "child_process"
    cp.exec "/opt/bender/helper_scripts/finviz.rb top_gainers", (error, stdout, stderr) ->
      if error
            msg.send "Sorry I encounted this error \n" + stderr
        else
            msg.send "The Top 20 Gainers today are:\n" + stdout

# Top 20 stocks with new Upgrades
  robot.respond /upgrades/i, (msg) ->
    cp = require "child_process"
    cp.exec "/opt/bender/helper_scripts/finviz.rb upgrades", (error, stdout, stderr) ->
      if error
            msg.send "Sorry I encounted this error \n" + stderr
        else
            msg.send "Top 20 stocks with new Upgrades are: \n" + stdout

# Top 20 stocks that are overbought
  robot.respond /overbought/i, (msg) ->
    cp = require "child_process"
    cp.exec "/opt/bender/helper_scripts/finviz.rb overbought", (error, stdout, stderr) ->
      if error
            msg.send "Sorry I encounted this error \n" + stderr
        else
            msg.send "Top Most Overbought Stocks (calculated by RSI(14)) Today are: \n" + stdout

# Top 20 stocks with Unusual Volume
  robot.respond /unusualvol/i, (msg) ->
    cp = require "child_process"
    cp.exec "/opt/bender/helper_scripts/finviz.rb unusualvol", (error, stdout, stderr) ->
      if error
            msg.send "Sorry I encounted this error \n" + stderr
        else
            msg.send "Top 20 stocks with Unusual Volume are: \n" + stdout

# Top 20 Most Volatile Stocks
  robot.respond /volatile/i, (msg) ->
    cp = require "child_process"
    cp.exec "/opt/bender/helper_scripts/finviz.rb volatile", (error, stdout, stderr) ->
      if error
            msg.send "Sorry I encounted this error \n" + stderr
        else
            msg.send "Top 20 Most Volatile Stocks Today are: \n" + stdout

# Top Most Oversold Stocks
  robot.respond /oversold/i, (msg) ->
    cp = require "child_process"
    cp.exec "/opt/bender/helper_scripts/finviz.rb oversold", (error, stdout, stderr) ->
      if error
            msg.send "Sorry I encounted this error \n" + stderr
        else
            msg.send "Top Most Oversold Stocks (calculated by RSI(14)) Today are: \n" + stdout

# Top 20 stocks making New 52 Week Lows
  robot.respond /new_lows/i, (msg) ->
    cp = require "child_process"
    cp.exec "/opt/bender/helper_scripts/finviz.rb new_lows", (error, stdout, stderr) ->
      if error
            msg.send "Sorry I encounted this error \n" + stderr
        else
            msg.send "Top 20 stocks making New 52 Week Lows Today are: \n" + stdout

# Top 20 stocks that are most active today
  robot.respond /most_active/i, (msg) ->
    cp = require "child_process"
    cp.exec "/opt/bender/helper_scripts/finviz.rb most_active", (error, stdout, stderr) ->
      if error
            msg.send "Sorry I encounted this error \n" + stderr
        else
            msg.send "Top 20 stocks that are most active today are: \n" + stdout


