class Genre
  attr_accessor :name, :songs

  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  extend Sluggable::ClassMethods
  include Sluggable::InstanceMethods

  extend Listable
  extend Findable

  def self.action(index)
    self.all[index-1].list_songs
  end

  def list_songs
    Song.all.each_with_index do |s, index|
      puts "#{index+1}. #{s.name}" if s.genre == self
    end
  end

  def self.reset_genres
    reset_all
  end
  reset_genres

  def url
    "#{name.downcase.strip}.html"
  end

  def initialize
    super
    @songs = []
  end

  def artists
    songs.collect{|s| s.artist}.uniq
  end

  def to_param
    self.slug
  end

end
