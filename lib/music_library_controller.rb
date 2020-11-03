class MusicLibraryController
    def initialize(path='./db/mp3s')
        @path = path
        @mi = MusicImporter.new(path)
        @mi.import
    end
    attr_accessor :path
    attr_reader :mi
    def call
        puts "Welcome to your music library!"
        str = ''
        while (str != 'exit')
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            str = gets.strip
            case str
            when 'list songs'
                self.list_songs
            when 'list artists'
                self.list_artists
            when 'list genres'
                self.list_genres
            when 'list artist'
                self.list_songs_by_artist
            when 'list genre'
                self.list_songs_by_genre
            when 'play song'
                self.play_song
            end
        end
    end
    def sort_by_name(array)
        array.sort{|a,b|a.name <=> b.name}
    end
    def sort_songs
        Song.all.sort{|a,b|a.name <=> b.name}
    end
    def list_songs
       # songs = self.mi.files.sort{|a,b|a.split(' - ')[1] <=> b.split(' - ')[1]}
       # songs.each_with_index{|song,index|puts "#{index + 1}. #{song.chomp('.mp3')}"}
       self.sort_songs.each_with_index{|song,index|puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end
    def list_artists
       # artists = self.mi.files.collect{|file| file.split(' - ')[0]}
       # artists.sort.uniq.each_with_index{|artist,index| puts "#{index + 1}. #{artist}"}
       artists = Artist.all.collect{|artist|artist.name}.sort
       artists.each_with_index{|artist,index|puts "#{index + 1}. #{artist}"}
    end
    def list_genres
        genre = Genre.all.collect{|genre|genre.name}.sort
        genre.each_with_index{|genre,index|puts "#{index + 1}. #{genre}"}
    end
    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist = gets.strip
        artist = Artist.find_by_name(artist)
        if artist
            songs = artist.songs.sort{|a,b|a.name<=>b.name}
            songs.each_with_index{|song,index|puts "#{index + 1}. #{song.name} - #{song.genre.name}"}
        end
    end
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre = gets.strip
        genre = Genre.find_by_name(genre)
        if genre
            songs = genre.songs.sort{|a,b|a.name <=> b.name}
            songs.each_with_index{|song,index|puts "#{index + 1}. #{song.artist.name} - #{song.name}"}
        end
    end
    def play_song
        songs = self.sort_songs
        puts "Which song number would you like to play?"
        num = gets.strip
        num = num.to_i
        if num.between?(1,songs.size)
            puts "Playing #{songs[num-1].name} by #{songs[num-1].artist.name}"
        end
    end
end