class Genre
    @@all = []
    def initialize(name)
        @name = name
        @songs = []
    end
    attr_accessor :name
    attr_reader :songs
    extend Concerns::Findable
    def self.all
        @@all
    end
    def self.destroy_all
        @@all.clear
    end
    def save
        @@all << self
    end
    def self.create(genre)
        Genre.new(genre).tap do |genre|
            genre.save
        end
    end
    def add_song(song)
        song.genre = self if !song.genre
        @songs << song if !songs.include?(song)
    end
    def artists
        songs.collect{|song| song.artist}.uniq
    end
end