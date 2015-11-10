module TVMaze
  class Error        < StandardError; end
  class Forbidden    < Error; end
  class Unauthorized < Error; end
  class NotFound     < Error; end
end
