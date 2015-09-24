class Artical < ActiveRecord::Base
  belongs_to :reader_config
  delegate :name, :to => :reader_config, :prefix => true
end
