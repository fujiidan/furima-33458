class ScheduledDelivery < ActiveHash::Base

  include ActiveHash::Associations
  has_many :items

  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '１〜２日で発送' },
    { id: 2, name: '２〜３日で発送' },
    { id: 3, name: '４〜７日で発送' }
  ]
end
