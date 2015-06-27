class Proxy::Connect < ActiveRecord::Base
  belongs_to :proxy, class_name: 'Proxy::Node', foreign_key: 'proxy_id'
  belongs_to :user

  state_machine :state, :initial => :active do
    event :remove do
      transition :active => :inactive
    end
  end

end
