require 'pry'
class Song
    @@all = []
    def initialize(name,artist=nil,genre=nil)
        @name = name
        self.artist = artist
        self.genre = genre
    end
    attr_accessor :name
    attr_reader :artist, :genre
    def save
        @@all << self
    end
    def artist=(artist)
        @artist = artist
        artist.add_song(self) if artist.is_a?(Artist)
    end
    def genre=(genre)
        @genre = genre
        genre.add_song(self) if genre.is_a?(Genre)
    end
    def self.all
        @@all
    end
    def self.destroy_all
        @@all.clear
    end
    def self.create(song)
        Song.new(song).tap do |song|
            song.save
        end
    end
    def self.find_by_name(name)
        @@all.find {|song| song.name == name}
    end
    def self.find_or_create_by_name(name)
        song = Song.find_by_name(name)
        song ? song : Song.create(name)
    end
    def self.new_from_filename(filename)
        song_data = filename.split(' - ')
        artist = Artist.find_or_create_by_name(song_data[0])
        genre = Genre.find_or_create_by_name(song_data[2].chomp('.mp3'))
        Song.new(song_data[1],artist,genre)
    end
    def self.create_from_filename(filename)
        song = new_from_filename(filename)
        song.save
    end
end

