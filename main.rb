
require File.dirname(__FILE__)+'/pokemensch.rb'

eval(File.read('config.rb'))

bot = PokeMensch.new(ConfigData)

bot.start