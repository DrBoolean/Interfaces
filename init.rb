require 'interface'
require 'implementer'
ActiveRecord::Base.extend(RescueRangers::Implementer)
