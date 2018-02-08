class Fingerprint < ApplicationRecord
  belongs_to :user

  validates_presence_of :fpos, :nfig, :base64_template
  validates_numericality_of :nfig
  validates_inclusion_of :fpos, in: [
      'LEFT_THUMB', 'LEFT_INDEX', 'LEFT_MIDDLE', 'LEFT_RING',
      'LEFT_LITTLE', 'RIGHT_THUMB', 'RIGHT_INDEX', 'RIGHT_MIDDLE',
      'RIGHT_RING', 'RIGHT_LITTLE'
  ]
end