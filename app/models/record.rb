class Record < ApplicationRecord
  belongs_to :user
  has_attached_file :audio,
                      :url => "/assets/:class/:id/:attachment/:style.:extension",
                      :path => ":rails_root/public/assets/records/:id/:style/:basename.:extension"
  validates_attachment_presence :audio
  validates_attachment_size :audio, :less_than => 3.megabytes
  validates_attachment_content_type :audio, :content_type => [ 'audio/mpeg',  'audio/mp3' ]
  
end
