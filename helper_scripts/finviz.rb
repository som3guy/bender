#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

input = ARGV[0]
case input
when 'new_highs'
  url = 'http://finviz.com/screener.ashx?v=110&s=ta_newhigh'
when 'top_gainers'
  url = 'http://finviz.com/screener.ashx?v=110&s=ta_topgainers'
when 'upgrades'
  url = 'http://finviz.com/screener.ashx?v=110&s=n_upgrades'
when 'overbought'
  url = 'http://finviz.com/screener.ashx?v=110&s=ta_overbought'
when 'unusualvol'
  url = 'http://finviz.com/screener.ashx?v=110&s=ta_unusualvolume'
when 'volatile'
  url = "http://finviz.com/screener.ashx?v=110&s=ta_mostvolatile"
when 'oversold'
  url = 'http://finviz.com/screener.ashx?v=110&s=ta_oversold'
when 'new_lows'
  url = 'http://finviz.com/screener.ashx?v=110&s=ta_newlow'
when 'most_active'
  url = 'http://finviz.com/screener.ashx?v=110&s=ta_mostactive'
end

doc = Nokogiri::HTML(open("#{url}"))
tickers = doc.xpath('//a').css("a[class=screener-link-primary]")

syms = Array.new
tickers.each do |sym|
  syms << sym.text
end

puts "#{syms.join(' ')}" 

