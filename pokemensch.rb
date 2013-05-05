require 'cinch'
require 'csv'

class PokeMensch

	def initialize(conf)
	
		$data = {}
	
		CSV.foreach("db.csv", :headers => false, :converters => :all) do |row|
		  $data[row[0]] = row[1].downcase
		end

		@bot = Cinch::Bot.new do
		
			configure do |c|
				c.server = conf[:server]
				c.channels = conf[:channels]
				c.nick = conf[:nick]
				c.user = conf[:user]
				
				$sleeptime = conf[:wait].to_f
			end
			
			on :message, ".on" do |m|
				@ison = true
			end
			
			on :message, ".off" do |m|
				@ison = false
			end
			
			on :message, /.{0,5}Question.+umerical.+/ do |m|
				if @ison == true
					sleep $sleeptime
					m_o = m.message.gsub(/[^A-Za-z ]/, '')
					m_o.gsub!(/[0-9]/,'')
					pokemang = m_o.split[1].downcase
					pokemang = pokemang[/([a-z]+)/]
					m.reply "#{$data.key(pokemang)}"
				end
			end
			
			on :message, /.{0,5}Question.{0,6}/ do |m|
				if @ison == true
					sleep $sleeptime
					m_o = m.message.gsub(/[^A-z0-9 ]/, '')
					m.reply "#{$data[m_o.split[1].to_i]}"
				end
			end
		end
	
	end
	
	def start
		@bot.start
	end
	
	def stop
		@bot.stop
	end
end