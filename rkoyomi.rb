#!/usr/bin/env ruby

#
#和暦西暦変換
#

require 'date'

class Koyomi < Date
  #明治から
  private
  def table
    #暦名,開始西暦年,開始月,開始日,終了和暦年
    #明治開始月日は旧暦からなので修正が必要
    #明治以前はややこしいので(時代によっては色々説もあるので)、一端無し
    [["明治", 1868, 9, 8, 45], ["大正", 1912, 7, 31, 15], ["昭和", 1926, 12, 25, 64], ["平成", 1989, 1, 8, nil]]
  end

  #和暦
  public
  def to_japan
    d = Date.new(year, month, day)

    table.size.times do |i|
      start_day = Date.new(table[i][1], table[i][2], table[i][3])
      if table[i+1]
        end_day = Date.new(table[i+1][1], table[i+1][2], table[i+1][3])
        return "#{table[i][0]}#{d.year-table[i][1]+1}年#{d.month}月#{d.day}日" if start_day <= d and d < end_day
      else
        end_day = DateTime.now
        return "#{table[i][0]}#{d.year-table[i][1]+1}年#{d.month}月#{d.day}日" if start_day <= d and d <= end_day
      end
    end
    return false
  end
end

year = ARGV.shift
exit 1 unless year

month = ARGV.shift
unless month
  puts Koyomi.new(year.to_i).to_japan
  exit 0
end

date= ARGV.shift
unless date
  puts Koyomi.new(year.to_i, month.to_i).to_japan
  exit 0
end

puts Koyomi.new(year.to_i, month.to_i, date.to_i).to_japan
