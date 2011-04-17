class User < ActiveRecord::Base
  has_many :rankings
  has_many :leagues, :through => :rankings
end
