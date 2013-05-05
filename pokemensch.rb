require 'cinch'
require 'csv'

pokemensch = {}
$on = false

CSV.foreach("db.csv", :headers => false, :converters => :all) do |row|
  pokemensch[row[0]] = row[1]
end

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.quakenet.org"
    c.channels = ["#kx"]
    c.nick = "pokemensch"
  end

  on :message, ".on" do |m|
    $on = true
  end
  on :message, ".off" do |m|
    $on = false
  end
  on :message, /.{0,5}Question.+umerical.+/ do |m|
    if $on == true
      sleep 5.0
      m_o = m.message.gsub(/[^A-Za-z ]/, '')
      m_o.gsub!(/[0-9]/,'')
      pokemang = m_o.split[1].downcase
      pokemang = pokemang[/([a-z]+)/]
      m.reply "#{pokemensch.key(pokemang)}"
    end
  end
  on :message, /.{0,5}Question.{0,6}/ do |m|
    if $on == true
      sleep 5.0
      m_o = m.message.gsub(/[^A-z0-9 ]/, '')
      m.reply "#{pokemensch[m_o.split[1].to_i]}"
    end
  end
end

bot.start