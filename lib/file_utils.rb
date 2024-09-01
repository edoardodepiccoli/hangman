class FileUtilities
  def initialize(path)
    @path = path
  end

  def load_file_words(min_length = 5, max_length = 12)
    File.readlines(path)
  end
end