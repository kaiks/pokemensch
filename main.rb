
require File.dirname(__FILE__)+'/pokemensch.rb'

eval(File.read('config.rb'))

bot = PokeMensh.new(ConfigData)

bot.start