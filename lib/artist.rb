class Artist
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
    def self.create(artist)
        Artist.new(artist).tap do |artist|
            artist.save
        end
    end
    def add_song(song)
        song.artist = self if !song.artist
        songs << song if !songs.include?(song)
    end
    def genres
        songs.collect{|song| song.genre}.uniq
    end

end