class MusicImporter
    def initialize(path)
        @path = path
    end
    attr_accessor :path
    def files
        mp3_files = []
        Dir.new(path).each do |file|
            mp3_files << file if file.end_with?('mp3')
        end
        mp3_files
    end
    def import 
        self.files.each do |song|
            Song.create_from_filename(song)
        end
    end
end